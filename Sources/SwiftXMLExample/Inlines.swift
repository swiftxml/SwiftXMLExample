import Foundation
import SwiftXMLComplete

@Step
func transformInlines_step(during execution: Execution, document: XDocument, shortNames: Bool = true) {
    inlineTransformation(shortNames: shortNames).execute(inDocument: document)
}

fileprivate func inlineTransformation(shortNames: Bool = true) -> XTransformation {
    XTransformation {
        
        XRule(forElements: "emphasis") { element in
            element.name = shortNames ? "b" : "bold"
        }
        
    }
}
