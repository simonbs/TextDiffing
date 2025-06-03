# 🧬 TextDiffing

<div align="center">
<img src="screenshot.png" width="405"/>

<h3>TextDiffing helps you create an <a href="https://developer.apple.com/documentation/foundation/attributedstring">AttributedString</a> / <a href="https://developer.apple.com/documentation/foundation/nsattributedstring">NSAttributedString</a> to visualize differences between texts.</h3>

 [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonbs%2FTextDiffing%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/simonbs/TextDiffing)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonbs%2FTextDiffing%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/simonbs/TextDiffing)\
[![Build](https://github.com/simonbs/TextDiffing/actions/workflows/build.yml/badge.svg)](https://github.com/simonbs/TextDiffing/actions/workflows/build.yml)
[![SwiftLint](https://github.com/simonbs/TextDiffing/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/simonbs/TextDiffing/actions/workflows/swiftlint.yml)
[![Run Tests](https://github.com/simonbs/TextDiffing/actions/workflows/test.yml/badge.svg)](https://github.com/simonbs/TextDiffing/actions/workflows/test.yml)
</div>

## ✨ Features

- Compare two strings and generate `AttributedString`/`NSAttributedString` highlighting differences
- Customize appearance of changes
- Supports word- and character-level diffing
- Lightweight and easy to integrate

## 📦 Adding the Package

TextDiffing is distributed using [Swift Package Manager](https://www.swift.org/documentation/package-manager/). Install TextDiffing in a project by adding it as a dependency in your Package.swift manifest or through “Package Dependencies” in project settings.

```swift
let package = Package(
    dependencies: [
        .package(url: "git@github.com:simonbs/textdiffing.git", from: "1.0.1")
    ]
)
```

## 📖 Documentation

The documentation is <a href="https://swiftpackageindex.com/simonbs/textdiffing/documentation">available on Swift Package Index</a>.

## 🚀 Getting Started

Use the TextDiffer to compare two strings.

```swift
let result = TextDiffer.diff(text, and: otherText)
```

The returned TextDiffResult has two properties:

|Property|Description|
|-|-|
|`attributedString`|The formatted `AttributedString` representing the differences.|
|`changeCount`|The number of changes (insertions or removals) between the texts.|

```swift
let attributedString = result.attributedString
let changeCount = result.changeCount
```

The `TextDiffer.diff(_:and:)` method also takes the following options.

|Option|Description|
|-|-|
|`strikethroughRemovedText`|Adds a strikethrough to removed text.|
|`tokenizeByCharacter`|Tokenizes the input by individual characters.|
|`tokenizeByWord`|Tokenizes the input by words (default).|

By default, text is tokenized by word. You can combine multiple options to customize behavior.

```swift
let result = TextDiffer.diff(text, and: otherText, options: [.tokenizeByCharacter, .strikethroughRemovedText])
```

You can customize the appearance of inserted and removed text by providing your own TextDiffStyle. This lets you control the background color used for visual highlighting.

```swift
let style = TextDiffStyle(
    insertedBackground: UIColor.systemGreen.withAlphaComponent(0.3),
    removedBackground: UIColor.systemRed.withAlphaComponent(0.3)
)
let result = TextDiffer.diff(text, and: otherText, style: style)
```

You may also use the extensions on NSAttributedString and AttributedString.

```swift
let attributedString = AttributedString(diffing: text, and: otherText)
let attributedString = NSAttributedString(diffing: text, and: otherText)
```

The initializers provided by the extensions also optionally take a style and options.

```swift
let attributedString = AttributedString(diffing: text, and: otherText, style: style, options: options)
let attributedString = NSAttributedString(diffing: text, and: otherText, style: style, options: options)
```
