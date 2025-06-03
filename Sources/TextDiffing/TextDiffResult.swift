import Foundation

/// Represents the result of a diff operation between two strings.
public struct TextDiffResult: Sendable {
    /// The number of changes (insertions or removals) between the texts.
    public let changeCount: Int
    /// The formatted `AttributedString` representing the differences.
    public let attributedString: AttributedString
}
