import Foundation

struct WordStringTokenizer: StringTokenizer {
    func tokenize(_ text: String) -> [String] {
        var result: [String] = []
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType) { _, tokenRange, _ in
            let word = (text as NSString).substring(with: tokenRange)
            result.append(contentsOf: splitByCharacterCategory(word))
        }
        return result
    }

    private func splitByCharacterCategory(_ token: String) -> [String] {
        guard var previous = token.first else { return [] }
        var result = [String(previous)]
        for char in token.dropFirst() {
            let sameCategory =
                (char.isLetter || char.isNumber) == (previous.isLetter || previous.isNumber) &&
                char.isWhitespace == previous.isWhitespace
            if sameCategory {
                result[result.count - 1].append(char)
            } else {
                result.append(String(char))
            }
            previous = char
        }
        return result
    }
}
