#if os(macOS)
import AppKit
typealias MPColor = NSColor

extension MPColor {
    convenience init(named name: String, in bundle: Bundle) {
        self.init(named: name, bundle: bundle)!
    }
}
#elseif os(iOS)
import UIKit
typealias MPColor = UIColor

extension MPColor {
    convenience init(named name: String, in bundle: Bundle) {
        self.init(named: name, in: bundle, compatibleWith: nil)!
    }
}
#endif
