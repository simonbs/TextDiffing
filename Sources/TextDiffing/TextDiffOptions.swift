public struct TextDiffOptions: OptionSet, Sendable {
    public static let strikethroughRemovedText = TextDiffOptions(rawValue: 1 << 0)
    public static let tokenizeByCharacter = TextDiffOptions(rawValue: 1 << 1)
    public static let tokenizeByWord = TextDiffOptions(rawValue: 1 << 2)

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
