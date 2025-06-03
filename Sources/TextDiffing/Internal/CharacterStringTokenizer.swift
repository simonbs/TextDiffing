import Foundation

struct CharacterStringTokenizer: StringTokenizer {
    func tokenize(_ text: String) -> [String] {
        Array(text).map { String($0) }
    }
}
