import Foundation

public struct TextDiffResult: Sendable {
    public let changeCount: Int
    public let attributedString: AttributedString
}
