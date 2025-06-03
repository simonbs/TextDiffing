#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

/// Defines the visual style used to highlight inserted and removed text in a diff.
public struct TextDiffStyle {
#if os(macOS)
    /// Background color for inserted text.
    public let insertedBackground: NSColor
    /// Background color for removed text.
    public let removedBackground: NSColor
#elseif os(iOS)
    /// Background color for inserted text.
    public let insertedBackground: UIColor
    /// Background color for removed text.
    public let removedBackground: UIColor
#endif
    
#if os(macOS)
    /// Creates a custom style with the given background colors.
    ///
    /// - Parameters:
    ///   - insertedBackground: Background color for inserted text.
    ///   - removedBackground: Background color for removed text.
    public init(insertedBackground: NSColor, removedBackground: NSColor) {
        self.insertedBackground = insertedBackground
        self.removedBackground = removedBackground
    }
#elseif os(iOS)
    /// Creates a custom style with the given background colors.
    /// 
    /// - Parameters:
    ///   - insertedBackground: Background color for inserted text.
    ///   - removedBackground: Background color for removed text.
    public init(insertedBackground: UIColor, removedBackground: UIColor) {
        self.insertedBackground = insertedBackground
        self.removedBackground = removedBackground
    }
#endif

    /// Creates a default style.
    public init() {
        self.insertedBackground = .diffBackgroundInsert
        self.removedBackground = .diffBackgroundRemove
    }
}
