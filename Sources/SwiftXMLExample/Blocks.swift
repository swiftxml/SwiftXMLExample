import Foundation
import SwiftXMLComplete

@Step
func transformBlocks_step(during execution: Execution, document: XDocument) {
    blockTransformation(during: execution).execute(inDocument: document)
}

fileprivate func blockTransformation(during execution: Execution) -> XTransformation {
    XTransformation {
        
        XRule(forElements: "paragraph") { element in
            execution.log(Message(id: "block element found", type: .info, fact: [.en: "found $0"]), node: element, element.name)
            element.name = "p"
        }
        
    }
}
