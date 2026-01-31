//
//  TextDiffTests.swift
//  TextDiffing
//
//  Created by Łukasz Rutkowski on 25/09/2025.
//

import Testing
@testable import TextDiffing
import Foundation

@Suite struct TextDiffTests {

    @Test func diffSegmentsWhenChangingWordOrder() async throws {
        let diffSegments = diff("one two", and: "two one")
        #expect(diffSegments == [
            DiffSegment(type: .removed, element: "one "),
            DiffSegment(type: .same, element: "two"),
            DiffSegment(type: .inserted, element: " one")
        ])
    }

    @Test func diffSegmentsWhenDeletingEverything() async throws {
        let diffSegments = diff("sentence with some text", and: "")
        #expect(diffSegments == [
            DiffSegment(type: .removed, element: "sentence with some text")
        ])
    }

    @Test func diffSegmentsWhenInsertingEverything() async throws {
        let diffSegments = diff("", and: "sentence with some text")
        #expect(diffSegments == [
            DiffSegment(type: .inserted, element: "sentence with some text")
        ])
    }

    @Test func diffSegmentsWhenDeletingWords() async throws {
        let diffSegments = diff("a b c d", and: "a c")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "a "),
            DiffSegment(type: .removed, element: "b "),
            DiffSegment(type: .same, element: "c"),
            DiffSegment(type: .removed, element: " d")
        ])
    }

    @Test func diffSegmentsWhenInsertingWords() async throws {
        let diffSegments = diff("a c", and: "a b c d")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "a "),
            DiffSegment(type: .inserted, element: "b "),
            DiffSegment(type: .same, element: "c"),
            DiffSegment(type: .inserted, element: " d")
        ])
    }

    @Test func diffSegmentsWhenChangingWord() async throws {
        let diffSegments = diff("dog pig", and: "dog cat")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "dog "),
            DiffSegment(type: .removed, element: "pig"),
            DiffSegment(type: .inserted, element: "cat")
        ])
    }

    private func diff(_ text: String, and otherText: String) -> [DiffSegment<String>] {
        let stringTokenizer = WordStringTokenizer()
        let sourceTokens = stringTokenizer.tokenize(text)
        let destinationTokens = stringTokenizer.tokenize(otherText)
        return destinationTokens.diffSegments(comparingWith: sourceTokens)
    }
}

extension DiffSegment: Equatable where Element: Equatable {
    public static func == (lhs: DiffSegment, rhs: DiffSegment) -> Bool {
        (lhs.type, lhs.element) == (rhs.type, rhs.element)
    }
}
