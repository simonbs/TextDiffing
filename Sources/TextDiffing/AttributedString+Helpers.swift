import Foundation

public extension AttributedString {
    init(diffing text: String, and otherText: String, options: TextDiffOptions = []) {
        let differ = TextDiffer.diff(text, and: otherText, options: options)
        self = differ.attributedString
    }
}
