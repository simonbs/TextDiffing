import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif

public extension NSAttributedString {
    /// Initializes an `NSAttributedString` representing the differences between two strings.
    ///
    /// - Parameters:
    ///   - text: The first input string.
    ///   - otherText: The second input string to compare with.
    ///   - style: The style used for inserted and removed text. Defaults to `TextDiffStyle()`.
    ///   - options: The diff options. Defaults to `[.tokenizeByWord]`.
    convenience init(
        diffing text: String,
        and otherText: String,
        style: TextDiffStyle = TextDiffStyle(),
        options: TextDiffOptions = [.tokenizeByWord]
    ) {
        let differ = TextDiffer.diff(text, and: otherText, style: style, options: options)
        let attributedString = NSAttributedString(differ.attributedString)
        self.init(attributedString: attributedString)
    }
}

extension NSAttributedString {
    convenience init(
        _ diffSegments: [DiffSegment<String>],
        style: TextDiffStyle = TextDiffStyle(),
        options: TextDiffOptions = [.tokenizeByWord]
    ) {
        let string = NSMutableAttributedString()
        for diffSegment in diffSegments {
            switch diffSegment.type {
            case .same:
                let attributedString = NSAttributedString(string: diffSegment.element)
                string.insert(attributedString, at: string.length)
            case .inserted:
                let attributedString = NSAttributedString(string: diffSegment.element, attributes: [
                    .backgroundColor: style.insertedBackground
                ])
                string.insert(attributedString, at: string.length)
            case .removed:
                var attributes: [NSAttributedString.Key: Any] = [
                    .backgroundColor: style.removedBackground
                ]
                if options.contains(.strikethroughRemovedText) {
                    attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
                }
                let attributedString = NSAttributedString(string: diffSegment.element, attributes: attributes)
                string.insert(attributedString, at: string.length)
            }
        }
        self.init(attributedString: string)
    }
}
