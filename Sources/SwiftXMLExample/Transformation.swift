import Foundation
import SwiftXMLComplete

@Step
func transform_step(during execution: Execution, document: XDocument, shortNames: Bool = true) {
    transformInlines_step(during: execution, document: document, shortNames: shortNames)
    transformBlocks_step(during: execution, document: document)
}
