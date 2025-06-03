import Foundation

/// A utility for computing visual differences between two text strings.
public struct TextDiffer {
    private init() {}

    /// Computes the visual differences between two strings.
    ///
    /// - Parameters:
    ///   - text: The first input string.
    ///   - otherText: The second input string to compare with.
    ///   - style: A `TextDiffStyle` used to style inserted and removed text. Defaults to `TextDiffStyle()`.
    ///   - options: A set of `TextDiffOptions` that configure the diff behavior. Defaults to `[.tokenizeByWord]`.
    /// - Returns: A `TextDiffResult` containing the change count and attributed representation of the diff.
    public static func diff(
        _ text: String,
        and otherText: String,
        style: TextDiffStyle = TextDiffStyle(),
        options: TextDiffOptions = [.tokenizeByWord]
    ) -> TextDiffResult {
        let stringTokenizer = stringTokenizer(for: options)
        let sourceTokens = stringTokenizer.tokenize(text)
        let destinationTokens = stringTokenizer.tokenize(otherText)
        let diffSegments = destinationTokens.diffSegments(comparingWith: sourceTokens)
        let changeCount = diffSegments.filter { $0.type == .inserted || $0.type == .removed }.count
        let nsAttributedString = NSAttributedString(diffSegments, style: style, options: options)
        let attributedString = AttributedString(nsAttributedString)
        return TextDiffResult(changeCount: changeCount, attributedString: attributedString)
    }
}

private extension TextDiffer {
    private static func stringTokenizer(for options: TextDiffOptions) -> StringTokenizer {
        if options.contains(.tokenizeByCharacter) {
            CharacterStringTokenizer()
        } else if options.contains(.tokenizeByWord) {
            WordStringTokenizer()
        } else {
            WordStringTokenizer()
        }
    }
}
