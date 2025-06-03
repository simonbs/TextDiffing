#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

public struct TextDiffStyle {
#if os(macOS)
    public let insertedBackground: NSColor
    public let removedBackground: NSColor
#elseif os(iOS)
    public let insertedBackground: UIColor
    public let removedBackground: UIColor
#endif
    
#if os(macOS)
    public init(insertedBackground: NSColor, removedBackground: NSColor) {
        self.insertedBackground = insertedBackground
        self.removedBackground = removedBackground
    }
#elseif os(iOS)
    public init(insertedBackground: UIColor, removedBackground: UIColor) {
        self.insertedBackground = insertedBackground
        self.removedBackground = removedBackground
    }
#endif

    public init() {
        self.insertedBackground = .diffBackgroundInsert
        self.removedBackground = .diffBackgroundRemove
    }
}
