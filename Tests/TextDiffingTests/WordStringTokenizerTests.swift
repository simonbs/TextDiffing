import Testing
@testable import TextDiffing

@Suite
final class WordStringTokenizerTests {
    @Test
    func it_tokenizes_single_word() async throws {
        let sut = WordStringTokenizer()
        let result = sut.tokenize("Hello")
        #expect(result == ["Hello"])
    }

    @Test
    func it_tokenizes_string_with_symbols() async throws {
        let sut = WordStringTokenizer()
        let result = sut.tokenize("Hello world!")
        #expect(result == ["Hello", " ", "world", "!"])
    }

    @Test
    func it_tokenizes_paragraph() async throws {
        let sut = WordStringTokenizer()
        // swiftlint:disable:next line_length
        let result = sut.tokenize("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mattis interdum dui, eu hendrerit nisi venenatis vel. Etiam diam justo, ullamcorper nec arcu nec, bibendum volutpat magna. Nulla vel risus ex. Proin facilisis massa id orci varius tincidunt. Vivamus porta, nisl et faucibus varius, tellus odio tristique mauris, quis consequat mi elit eu risus. Integer quis sem nulla. Duis accumsan ipsum posuere magna consectetur, et lobortis turpis ullamcorper. Etiam sit amet justo ac felis aliquet congue. Nam ac ligula vestibulum, varius lorem id, volutpat diam. Integer leo turpis, vestibulum eget pellentesque quis, mollis non libero. Morbi suscipit nisl dolor, et laoreet ligula eleifend quis. Etiam sit amet aliquet risus, id blandit augue.")
        // swiftlint:disable:next line_length
        #expect(result == ["Lorem", " ", "ipsum", " ", "dolor", " ", "sit", " ", "amet", ",", " ", "consectetur", " ", "adipiscing", " ", "elit", ".", " ", "Nam", " ", "mattis", " ", "interdum", " ", "dui", ",", " ", "eu", " ", "hendrerit", " ", "nisi", " ", "venenatis", " ", "vel", ".", " ", "Etiam", " ", "diam", " ", "justo", ",", " ", "ullamcorper", " ", "nec", " ", "arcu", " ", "nec", ",", " ", "bibendum", " ", "volutpat", " ", "magna", ".", " ", "Nulla", " ", "vel", " ", "risus", " ", "ex", ".", " ", "Proin", " ", "facilisis", " ", "massa", " ", "id", " ", "orci", " ", "varius", " ", "tincidunt", ".", " ", "Vivamus", " ", "porta", ",", " ", "nisl", " ", "et", " ", "faucibus", " ", "varius", ",", " ", "tellus", " ", "odio", " ", "tristique", " ", "mauris", ",", " ", "quis", " ", "consequat", " ", "mi", " ", "elit", " ", "eu", " ", "risus", ".", " ", "Integer", " ", "quis", " ", "sem", " ", "nulla", ".", " ", "Duis", " ", "accumsan", " ", "ipsum", " ", "posuere", " ", "magna", " ", "consectetur", ",", " ", "et", " ", "lobortis", " ", "turpis", " ", "ullamcorper", ".", " ", "Etiam", " ", "sit", " ", "amet", " ", "justo", " ", "ac", " ", "felis", " ", "aliquet", " ", "congue", ".", " ", "Nam", " ", "ac", " ", "ligula", " ", "vestibulum", ",", " ", "varius", " ", "lorem", " ", "id", ",", " ", "volutpat", " ", "diam", ".", " ", "Integer", " ", "leo", " ", "turpis", ",", " ", "vestibulum", " ", "eget", " ", "pellentesque", " ", "quis", ",", " ", "mollis", " ", "non", " ", "libero", ".", " ", "Morbi", " ", "suscipit", " ", "nisl", " ", "dolor", ",", " ", "et", " ", "laoreet", " ", "ligula", " ", "eleifend", " ", "quis", ".", " ", "Etiam", " ", "sit", " ", "amet", " ", "aliquet", " ", "risus", ",", " ", "id", " ", "blandit", " ", "augue", "."])
    }
}
