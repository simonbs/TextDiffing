import Foundation

public extension AttributedString {
    init(
        diffing text: String,
        and otherText: String,
        style: TextDiffStyle = TextDiffStyle(),
        options: TextDiffOptions = []
    ) {
        let differ = TextDiffer.diff(text, and: otherText, style: style, options: options)
        self = differ.attributedString
    }
}
