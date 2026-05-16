//
//  TextDiffTests.swift
//  TextDiffing
//
//  Created by Łukasz Rutkowski on 25/09/2025.
//

import Foundation
import Testing
@testable import TextDiffing

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

    @Test func diffSegmentsWhenDeletingSpace() async throws {
        let diffSegments = diff(". onTapGesture", and: ".onTapGesture")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "."),
            DiffSegment(type: .removed, element: " "),
            DiffSegment(type: .same, element: "onTapGesture")
        ])
    }

    @Test func diffSegmentsWhenInsertingSpace() async throws {
        let diffSegments = diff(".onTapGesture", and: ". onTapGesture")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "."),
            DiffSegment(type: .inserted, element: " "),
            DiffSegment(type: .same, element: "onTapGesture")
        ])
    }

    @Test func diffSegmentsWhenRemovingPeriodAtEndOfSentence() async throws {
        let diffSegments = diff("Hello world.", and: "Hello world")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "Hello world"),
            DiffSegment(type: .removed, element: ".")
        ])
    }

    @Test func diffSegmentsWhenAppendingPunctuation() async throws {
        let diffSegments = diff("Hello", and: "Hello!")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "Hello"),
            DiffSegment(type: .inserted, element: "!")
        ])
    }

    @Test func diffSegmentsWhenChangingWordNearParentheses() async throws {
        let diffSegments = diff("func(a)", and: "func(b)")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "func("),
            DiffSegment(type: .removed, element: "a"),
            DiffSegment(type: .inserted, element: "b"),
            DiffSegment(type: .same, element: ")")
        ])
    }

    @Test func diffSegmentsWhenReplacingOperator() async throws {
        let diffSegments = diff("a + b", and: "a - b")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "a "),
            DiffSegment(type: .removed, element: "+"),
            DiffSegment(type: .inserted, element: "-"),
            DiffSegment(type: .same, element: " b")
        ])
    }

    @Test func diffSegmentsWhenRemovingPunctuation() async throws {
        let diffSegments = diff("Hello, world!", and: "Hello world")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "Hello"),
            DiffSegment(type: .removed, element: ","),
            DiffSegment(type: .same, element: " world"),
            DiffSegment(type: .removed, element: "!")
        ])
    }

    @Test func diffSegmentsWhenRemovingSpaceBetweenWords() async throws {
        let diffSegments = diff("Hello World", and: "HelloWorld")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "Hello"),
            DiffSegment(type: .removed, element: " "),
            DiffSegment(type: .same, element: "World")
        ])
    }

    @Test func diffSegmentsWhenInsertingSpaceBetweenWords() async throws {
        let diffSegments = diff("HelloWorld", and: "Hello World")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "Hello"),
            DiffSegment(type: .inserted, element: " "),
            DiffSegment(type: .same, element: "World")
        ])
    }

    @Test func diffSegmentsWhenRemovingSpaceInFirstPairOfThreeWords() async throws {
        let diffSegments = diff("one two three", and: "onetwo three")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "one"),
            DiffSegment(type: .removed, element: " "),
            DiffSegment(type: .same, element: "two three")
        ])
    }

    @Test func diffSegmentsWhenRemovingSpaceInLastPairOfThreeWords() async throws {
        let diffSegments = diff("one two three", and: "one twothree")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "one two"),
            DiffSegment(type: .removed, element: " "),
            DiffSegment(type: .same, element: "three")
        ])
    }

    @Test func diffSegmentsWhenChangingNumberAfterSymbol() async throws {
        let diffSegments = diff("price is $10", and: "price is $20")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "price is $"),
            DiffSegment(type: .removed, element: "10"),
            DiffSegment(type: .inserted, element: "20")
        ])
    }

    @Test func diffSegmentsWhenInsertingHashtagAndRemovingInternalSpace() async throws {
        let diffSegments = diff("Fedora 44", and: "#Fedora44")
        #expect(diffSegments == [
            DiffSegment(type: .inserted, element: "#"),
            DiffSegment(type: .same, element: "Fedora"),
            DiffSegment(type: .removed, element: " "),
            DiffSegment(type: .same, element: "44")
        ])
    }

    @Test func diffSegmentsWhenInsertingMultipleHashtagsWithBoundaryRealignment() async throws {
        let diffSegments = diff("macOS 26 Fedora 44", and: "#macOS 26 #Fedora44")
        #expect(diffSegments == [
            DiffSegment(type: .inserted, element: "#"),
            DiffSegment(type: .same, element: "macOS 26 "),
            DiffSegment(type: .inserted, element: "#"),
            DiffSegment(type: .same, element: "Fedora"),
            DiffSegment(type: .removed, element: " "),
            DiffSegment(type: .same, element: "44")
        ])
    }

    @Test func diffSegmentsWhenInsertingMultilineBreaks() async throws {
        let diffSegments = diff("First. Second.", and: "First.\nSecond.")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "First."),
            DiffSegment(type: .removed, element: " "),
            DiffSegment(type: .inserted, element: "\n"),
            DiffSegment(type: .same, element: "Second.")
        ])
    }

    @Test func diffSegmentsWhenRemovingApostropheInContraction() async throws {
        let diffSegments = diff("don't stop", and: "dont stop")
        #expect(diffSegments == [
            DiffSegment(type: .removed, element: "don't"),
            DiffSegment(type: .inserted, element: "dont"),
            DiffSegment(type: .same, element: " stop")
        ])
    }

    @Test func diffSegmentsWhenReplacingHyphenWithSpace() async throws {
        let diffSegments = diff("state-of-the-art", and: "state of the art")
        #expect(diffSegments == [
            DiffSegment(type: .same, element: "state"),
            DiffSegment(type: .removed, element: "-"),
            DiffSegment(type: .inserted, element: " "),
            DiffSegment(type: .same, element: "of"),
            DiffSegment(type: .removed, element: "-"),
            DiffSegment(type: .inserted, element: " "),
            DiffSegment(type: .same, element: "the"),
            DiffSegment(type: .removed, element: "-"),
            DiffSegment(type: .inserted, element: " "),
            DiffSegment(type: .same, element: "art")
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
