import Foundation
import SwiftXMLComplete
import LoopsOnOptionals

@Step
func transformBlocks_step(during execution: Execution, document: XDocument) {
    
    // It's always nice to greet first, but when transformInlines_step has
    // been called before which also greets, we won't greet again:
    greeting_step(during: execution, remark: "in transformBlocks_step")
    
    // ...but we might force to greet:
    execution.force {
        greeting_step(during: execution, remark: "forced in transformBlocks_step")
    }
    
    blockTransformation(during: execution).execute(inDocument: document)
}

fileprivate func blockTransformation(during execution: Execution) -> XTransformation {
    XTransformation {
        
        XRule(forElements: "paragraph") { element in
            execution.log(Message(id: "block element found", type: .info, fact: [.en: #"found block element "$0""#]), node: element, element.name)
            element.name = "p"
        }
        
    }
}
