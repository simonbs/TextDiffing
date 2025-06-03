@testable import TextDiffing
import Testing

@Suite
final class CharacterStringTokenizerTests {
    @Test
    func it_tokenizes_single_word() async throws {
        let sut = CharacterStringTokenizer()
        let result = sut.tokenize("Hello")
        #expect(result == ["H", "e", "l", "l", "o"])
    }

    @Test
    func it_tokenizes_string_with_symbols() async throws {
        let sut = CharacterStringTokenizer()
        let result = sut.tokenize("Hello world!")
        #expect(result == ["H", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "!"])
    }

    @Test
    func it_tokenizes_paragraph() async throws {
        let sut = CharacterStringTokenizer()
        // swiftlint:disable:next line_length
        let result = sut.tokenize("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mattis interdum dui, eu hendrerit nisi venenatis vel. Etiam diam justo, ullamcorper nec arcu nec, bibendum volutpat magna. Nulla vel risus ex. Proin facilisis massa id orci varius tincidunt. Vivamus porta, nisl et faucibus varius, tellus odio tristique mauris, quis consequat mi elit eu risus. Integer quis sem nulla. Duis accumsan ipsum posuere magna consectetur, et lobortis turpis ullamcorper. Etiam sit amet justo ac felis aliquet congue. Nam ac ligula vestibulum, varius lorem id, volutpat diam. Integer leo turpis, vestibulum eget pellentesque quis, mollis non libero. Morbi suscipit nisl dolor, et laoreet ligula eleifend quis. Etiam sit amet aliquet risus, id blandit augue.")
        // swiftlint:disable:next line_length
        #expect(result == ["L", "o", "r", "e", "m", " ", "i", "p", "s", "u", "m", " ", "d", "o", "l", "o", "r", " ", "s", "i", "t", " ", "a", "m", "e", "t", ",", " ", "c", "o", "n", "s", "e", "c", "t", "e", "t", "u", "r", " ", "a", "d", "i", "p", "i", "s", "c", "i", "n", "g", " ", "e", "l", "i", "t", ".", " ", "N", "a", "m", " ", "m", "a", "t", "t", "i", "s", " ", "i", "n", "t", "e", "r", "d", "u", "m", " ", "d", "u", "i", ",", " ", "e", "u", " ", "h", "e", "n", "d", "r", "e", "r", "i", "t", " ", "n", "i", "s", "i", " ", "v", "e", "n", "e", "n", "a", "t", "i", "s", " ", "v", "e", "l", ".", " ", "E", "t", "i", "a", "m", " ", "d", "i", "a", "m", " ", "j", "u", "s", "t", "o", ",", " ", "u", "l", "l", "a", "m", "c", "o", "r", "p", "e", "r", " ", "n", "e", "c", " ", "a", "r", "c", "u", " ", "n", "e", "c", ",", " ", "b", "i", "b", "e", "n", "d", "u", "m", " ", "v", "o", "l", "u", "t", "p", "a", "t", " ", "m", "a", "g", "n", "a", ".", " ", "N", "u", "l", "l", "a", " ", "v", "e", "l", " ", "r", "i", "s", "u", "s", " ", "e", "x", ".", " ", "P", "r", "o", "i", "n", " ", "f", "a", "c", "i", "l", "i", "s", "i", "s", " ", "m", "a", "s", "s", "a", " ", "i", "d", " ", "o", "r", "c", "i", " ", "v", "a", "r", "i", "u", "s", " ", "t", "i", "n", "c", "i", "d", "u", "n", "t", ".", " ", "V", "i", "v", "a", "m", "u", "s", " ", "p", "o", "r", "t", "a", ",", " ", "n", "i", "s", "l", " ", "e", "t", " ", "f", "a", "u", "c", "i", "b", "u", "s", " ", "v", "a", "r", "i", "u", "s", ",", " ", "t", "e", "l", "l", "u", "s", " ", "o", "d", "i", "o", " ", "t", "r", "i", "s", "t", "i", "q", "u", "e", " ", "m", "a", "u", "r", "i", "s", ",", " ", "q", "u", "i", "s", " ", "c", "o", "n", "s", "e", "q", "u", "a", "t", " ", "m", "i", " ", "e", "l", "i", "t", " ", "e", "u", " ", "r", "i", "s", "u", "s", ".", " ", "I", "n", "t", "e", "g", "e", "r", " ", "q", "u", "i", "s", " ", "s", "e", "m", " ", "n", "u", "l", "l", "a", ".", " ", "D", "u", "i", "s", " ", "a", "c", "c", "u", "m", "s", "a", "n", " ", "i", "p", "s", "u", "m", " ", "p", "o", "s", "u", "e", "r", "e", " ", "m", "a", "g", "n", "a", " ", "c", "o", "n", "s", "e", "c", "t", "e", "t", "u", "r", ",", " ", "e", "t", " ", "l", "o", "b", "o", "r", "t", "i", "s", " ", "t", "u", "r", "p", "i", "s", " ", "u", "l", "l", "a", "m", "c", "o", "r", "p", "e", "r", ".", " ", "E", "t", "i", "a", "m", " ", "s", "i", "t", " ", "a", "m", "e", "t", " ", "j", "u", "s", "t", "o", " ", "a", "c", " ", "f", "e", "l", "i", "s", " ", "a", "l", "i", "q", "u", "e", "t", " ", "c", "o", "n", "g", "u", "e", ".", " ", "N", "a", "m", " ", "a", "c", " ", "l", "i", "g", "u", "l", "a", " ", "v", "e", "s", "t", "i", "b", "u", "l", "u", "m", ",", " ", "v", "a", "r", "i", "u", "s", " ", "l", "o", "r", "e", "m", " ", "i", "d", ",", " ", "v", "o", "l", "u", "t", "p", "a", "t", " ", "d", "i", "a", "m", ".", " ", "I", "n", "t", "e", "g", "e", "r", " ", "l", "e", "o", " ", "t", "u", "r", "p", "i", "s", ",", " ", "v", "e", "s", "t", "i", "b", "u", "l", "u", "m", " ", "e", "g", "e", "t", " ", "p", "e", "l", "l", "e", "n", "t", "e", "s", "q", "u", "e", " ", "q", "u", "i", "s", ",", " ", "m", "o", "l", "l", "i", "s", " ", "n", "o", "n", " ", "l", "i", "b", "e", "r", "o", ".", " ", "M", "o", "r", "b", "i", " ", "s", "u", "s", "c", "i", "p", "i", "t", " ", "n", "i", "s", "l", " ", "d", "o", "l", "o", "r", ",", " ", "e", "t", " ", "l", "a", "o", "r", "e", "e", "t", " ", "l", "i", "g", "u", "l", "a", " ", "e", "l", "e", "i", "f", "e", "n", "d", " ", "q", "u", "i", "s", ".", " ", "E", "t", "i", "a", "m", " ", "s", "i", "t", " ", "a", "m", "e", "t", " ", "a", "l", "i", "q", "u", "e", "t", " ", "r", "i", "s", "u", "s", ",", " ", "i", "d", " ", "b", "l", "a", "n", "d", "i", "t", " ", "a", "u", "g", "u", "e", "."])
    }
}
