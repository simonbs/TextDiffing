import Foundation

public extension AttributedString {
    /// Initializes an `AttributedString` representing the differences between two strings.
    ///
    /// - Parameters:
    ///   - text: The first input string.
    ///   - otherText: The second input string to compare with.
    ///   - style: The style used for inserted and removed text. Defaults to `TextDiffStyle()`.
    ///   - options: The diff options. Defaults to `[.tokenizeByWord]`.
    init(
        diffing text: String,
        and otherText: String,
        style: TextDiffStyle = TextDiffStyle(),
        options: TextDiffOptions = [.tokenizeByWord]
    ) {
        let differ = TextDiffer.diff(text, and: otherText, style: style, options: options)
        self = differ.attributedString
    }
}
