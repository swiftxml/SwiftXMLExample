import ArgumentParser
import SwiftXMLComplete

@main struct SwiftXMLExample: AsyncParsableCommand {
    
    @Argument(help: #"The source file."#)
    var source: String
    
    @Option(name: [.long], help: #"The target file."#)
    var target: String
    
    @Option(name: [.long], help: #"Using the short form of the resulting elements?"#)
    var shortNames: Bool = true
    
    @Option(name: [.long], help: #"The log file."#)
    var log: String
    
    func run() async throws {
        
        let logger = MultiLogger(
            try FileLogger<ExecutionLogEntry,InfoType>(usingFile: log),
            LogEntryPrinter(),
        )
        
        let executionEventProcessor = EventProcessorForLogger(
            withMetaDataInfo: "SwiftXMLExample",
            logger: logger,
            excutionInfoFormat: ExecutionInfoFormat(
                withTime: true,
                addMetaDataInfo: true,
                addIndentation: true,
                addType: true,
                addExecutionPath: true,
                addStructuralID: false
            )
        )
        
        let execution = Execution(executionEventProcessor: executionEventProcessor)
        
        let document: XDocument
        do {
            document = try parseXML(fromPath: source)
        } catch {
            throw FatalError(id: "read eror", message: "could not read \(source): \(String(describing: error))", during: execution)
        }
        
        transform_step(during: execution, document: document, shortNames: shortNames)
        
        do {
            try document.write(toPath: target)
        } catch {
            throw FatalError(id: "write eror", message: "could not write \(source): \(String(describing: error))", during: execution)
        }
        
        try execution.closeEventProcessing()
        
    }
    
}

public struct FatalError: Error, CustomStringConvertible  {
    public let description: String
    
    var localizedDescription: String { description }
    
    public init(id: String, message: String, during execution: Execution) {
        self.description = message
        execution.log(Message(id: id, type: .fatal, fact: [.en: message]))
        do { try execution.closeEventProcessing() } catch {}
    }
}
