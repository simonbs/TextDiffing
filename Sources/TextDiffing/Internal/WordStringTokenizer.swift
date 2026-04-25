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
        guard let firstChar = token.first else { return [] }
        var result: [String] = []
        var currentRun = String(firstChar)
        var currentCategory = category(of: firstChar)
        for char in token.dropFirst() {
            let charCategory = category(of: char)
            if charCategory != currentCategory {
                result.append(currentRun)
                currentRun = String(char)
                currentCategory = charCategory
            } else {
                currentRun.append(char)
            }
        }
        result.append(currentRun)
        return result
    }

    private enum CharacterCategory {
        case word
        case whitespace
        case punctuation
    }

    private func category(of char: Character) -> CharacterCategory {
        if char.isLetter || char.isNumber {
            return .word
        } else if char.isWhitespace {
            return .whitespace
        } else {
            return .punctuation
        }
    }
}
