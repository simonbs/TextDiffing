/// Options that configure how differences between texts are computed and displayed.
public struct TextDiffOptions: OptionSet, Sendable {
    /// Applies a strikethrough style to removed text.
    public static let strikethroughRemovedText = Self(rawValue: 1 << 0)
    /// Tokenizes input by individual characters.
    public static let tokenizeByCharacter = Self(rawValue: 1 << 1)
    /// Tokenizes input by words (default).
    public static let tokenizeByWord = Self(rawValue: 1 << 2)

    /// The raw integer value representing the option set.
    public let rawValue: Int

    /// Creates a new option set from a raw value.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
