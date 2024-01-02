//
//  UIColorExt.swift
//
//
//  Created by tnhn on 2.01.2024.
//

import SwiftUI
import UIKit

//MARK: - UIColor
extension UIColor{
  /// Creates a UIColor from a hexadecimal string.
  ///
  /// This initializer converts a hex string into a UIColor object.
  /// It supports hex strings in 3, 6, and 8 digits, representing RGB and ARGB values.
  ///
  /// - Parameter hexString: A hexadecimal string representation of the color.
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt64()
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
  
  /// Creates a UIColor from RGB values.
  ///
  /// - Parameters:
  ///   - red: Red component of the color.
  ///   - green: Green component of the color.
  ///   - blue: Blue component of the color.
  /// - Returns: A UIColor object with the specified RGB values.
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
  }
  
  /// Converts a UIColor to a hexadecimal string representation.
  ///
  /// - Parameter color: The UIColor to convert to a hex string.
  /// - Returns: A hexadecimal string representation of the color.
  func hexStringFromColor(color: UIColor) -> String {
    let components = color.cgColor.components
    let r: CGFloat = components?[0] ?? 0.0
    let g: CGFloat = components?[1] ?? 0.0
    let b: CGFloat = components?[2] ?? 0.0
    
    let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    return hexString
  }
}

//MARK: - Color
@available(iOS 13.0, *)
extension Color{
  /// Initializes a SwiftUI Color from a hexadecimal string.
  ///
  /// This initializer allows creating a SwiftUI Color directly from a hex string.
  ///
  /// - Parameter hexString: A hexadecimal string representation of the color.
  init(hexString: String){
    self.init(UIColor(hexString: hexString))
  }
}
