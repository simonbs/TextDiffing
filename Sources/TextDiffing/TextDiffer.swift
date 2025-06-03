import Foundation

public struct TextDiffer {
    private init() {}

    public static func diff(
        _ text: String,
        and otherText: String,
        style: TextDiffStyle = TextDiffStyle(),
        options: TextDiffOptions = []
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
