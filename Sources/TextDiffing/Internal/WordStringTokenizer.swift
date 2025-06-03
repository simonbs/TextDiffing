import Foundation

struct WordStringTokenizer: StringTokenizer {
    func tokenize(_ text: String) -> [String] {
        var result: [String] = []
        let characterSet = CharacterSet.whitespacesAndNewlines
            .union(.symbols)
            .union(.punctuationCharacters)
            .subtracting(CharacterSet(charactersIn: "'’"))
        var token = ""
        for character in text {
            if characterSet.containsUnicodeScalars(of: character) {
                if !token.isEmpty {
                    result.append(token)
                    token = ""
                }
                result.append(String(character))
            } else {
                token += String(character)
            }
        }
        if !token.isEmpty {
            result.append(token)
        }
        return result
    }
}

private extension CharacterSet {
    func containsUnicodeScalars(of character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy(contains(_:))
    }
}
