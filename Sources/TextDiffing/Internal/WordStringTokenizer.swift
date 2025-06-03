import Foundation

struct WordStringTokenizer: StringTokenizer {
    func tokenize(_ text: String) -> [String] {
        var result: [String] = []
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType) { _, tokenRange, _ in
            let word = (text as NSString).substring(with: tokenRange)
            result.append(word)
        }
        return result
    }
}

private extension CharacterSet {
    func containsUnicodeScalars(of character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy(contains(_:))
    }
}
