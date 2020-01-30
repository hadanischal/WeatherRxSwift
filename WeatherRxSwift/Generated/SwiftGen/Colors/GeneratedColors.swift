// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 80% <br/> (0x000000cc)
  internal static let black100trans80 = ColorName(rgbaValue: 0x000000cc)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ee9d39"></span>
  /// Alpha: 100% <br/> (0xee9d39ff)
  internal static let brightOrange = ColorName(rgbaValue: 0xee9d39ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0c2933"></span>
  /// Alpha: 100% <br/> (0x0c2933ff)
  internal static let buyUnselected = ColorName(rgbaValue: 0x0c2933ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#4c4d4e"></span>
  /// Alpha: 100% <br/> (0x4c4d4eff)
  internal static let cancelButtonColour = ColorName(rgbaValue: 0x4c4d4eff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#131415"></span>
  /// Alpha: 100% <br/> (0x131415ff)
  internal static let charcoal100 = ColorName(rgbaValue: 0x131415ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#50595b"></span>
  /// Alpha: 100% <br/> (0x50595bff)
  internal static let charcoal70 = ColorName(rgbaValue: 0x50595bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#1e2a2c"></span>
  /// Alpha: 100% <br/> (0x1e2a2cff)
  internal static let charcoal90 = ColorName(rgbaValue: 0x1e2a2cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f46f60"></span>
  /// Alpha: 100% <br/> (0xf46f60ff)
  internal static let coral = ColorName(rgbaValue: 0xf46f60ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d93d5a"></span>
  /// Alpha: 100% <br/> (0xd93d5aff)
  internal static let darkRed = ColorName(rgbaValue: 0xd93d5aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#58b537"></span>
  /// Alpha: 100% <br/> (0x58b537ff)
  internal static let green537 = ColorName(rgbaValue: 0x58b537ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0d2a34"></span>
  /// Alpha: 100% <br/> (0x0d2a34ff)
  internal static let headerBuy = ColorName(rgbaValue: 0x0d2a34ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#1d1e1f"></span>
  /// Alpha: 100% <br/> (0x1d1e1fff)
  internal static let headerColour = ColorName(rgbaValue: 0x1d1e1fff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#01ffff"></span>
  /// Alpha: 100% <br/> (0x01ffffff)
  internal static let neon100 = ColorName(rgbaValue: 0x01ffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#07bcdc"></span>
  /// Alpha: 100% <br/> (0x07bcdcff)
  internal static let primary = ColorName(rgbaValue: 0x07bcdcff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#33ff99"></span>
  /// Alpha: 100% <br/> (0x33ff99ff)
  internal static let rarthGreen100 = ColorName(rgbaValue: 0x33ff99ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#1a1200"></span>
  /// Alpha: 100% <br/> (0x1a1200ff)
  internal static let sellUnselected = ColorName(rgbaValue: 0x1a1200ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#292a2b"></span>
  /// Alpha: 100% <br/> (0x292a2bff)
  internal static let textFieldBaground = ColorName(rgbaValue: 0x292a2bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#00c5cd"></span>
  /// Alpha: 100% <br/> (0x00c5cdff)
  internal static let turquoiseSurf = ColorName(rgbaValue: 0x00c5cdff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f5f5"></span>
  /// Alpha: 100% <br/> (0xf5f5f5ff)
  internal static let whiteSmoke = ColorName(rgbaValue: 0xf5f5f5ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
