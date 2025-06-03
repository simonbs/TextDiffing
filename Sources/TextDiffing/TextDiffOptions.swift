public struct TextDiffOptions: OptionSet, Sendable {
    public static let strikethroughRemovedText = TextDiffOptions(rawValue: 1 << 0)
    public static let tokenizeByCharacter = TextDiffOptions(rawValue: 2 << 0)
    public static let tokenizeByWord = TextDiffOptions(rawValue: 3 << 0)

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
