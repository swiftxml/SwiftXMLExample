import Foundation
import Pipeline

fileprivate let greetingMessage = Message(
    id: "greeting",
    type: .info,
    fact: [.en: "Hello ($0)!"]
)

@Step
func greeting_step(during execution: Execution, remark: String) {
    execution.log(greetingMessage, remark)
}
