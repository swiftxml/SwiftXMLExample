import Foundation
import SwiftXMLComplete
import LoopsOnOptionals

@Step
func transformInlines_step(during execution: Execution, document: XDocument, shortNames: Bool = true) {
    
    // It's always nice to greet first (the following call can be seen as a precondition):
    greeting_step(during: execution, remark: "in transformInlines_step")
    
    inlineTransformation(shortNames: shortNames).execute(inDocument: document)
}

fileprivate func inlineTransformation(shortNames: Bool = true) -> XTransformation {
    XTransformation {
        
        XRule(forElements: "emphasis") { element in
            element.name = shortNames ? "b" : "bold"
        }
        
    }
}
