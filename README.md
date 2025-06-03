# TextDiffing

Diff two texts to find the changes.

![](screenshot.png)

### Usage

Use the TextDiffer to compare two strings.

```swift
let result = TextDiffer.diff(text, and: otherText)
let changeCount = result.changeCount
let attributedString = result.attributedString
```

The `diff(_:and:)` also takes options.

```swift
let result = TextDiffer.diff(text, and: otherText, options: [.tokenizeByCharacter, .strikethroughRemovedText])
```

You may also use the extensions on NSAttributedString and AttributedString.

```swift
let attributedString = AttributedString(diffing: text, and: otherText)
```

```swift
let attributedString = NSAttributedString(diffing: text, and: otherText)
```
