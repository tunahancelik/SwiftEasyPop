//
//  TextModifier.swift
//  
//
//  Created by tnhn on 2.01.2024.
//

import SwiftUI

/// A `ViewModifier` to apply custom styling to text views.
///
/// This modifier can be used to uniformly style text across your application.
/// It applies multiple text alignment, font, foreground color, and line limit to the content.
@available(iOS 14.0, *)
struct TextModifier: ViewModifier {
  
  let multiTextAlignment: TextAlignment
  let font: Font
  let foregroundColor: Color
  let lineLimit: Int
  
  /// Modifies the content view with text-related styles.
  ///
  /// - Parameter content: The content view to which the styles will be applied.
  /// - Returns: A modified view with the specified text styles.
  func body(content: Content) -> some View {
    content
      .multilineTextAlignment(multiTextAlignment)
      .font(font)
      .foregroundColor(foregroundColor)
      .lineLimit(lineLimit)
  }
}

/// An extension on `View` to provide an easy way to apply the `TextModifier`.
///
/// This extension adds a `textVM` method to any SwiftUI view, allowing for easy customization of text-related properties.
@available(iOS 14.0, *)
extension View {
  
  /// Applies custom text styling to the view.
  ///
  /// This method is a convenient way to apply common text styles like alignment, font, foreground style, and line limit.
  ///
  /// - Parameters:
  ///   - multiTextAlignment: The alignment of the text within the view.
  ///   - font: The font to be used for the text.
  ///   - foregroundStyle: The color of the text.
  ///   - lineLimit: The maximum number of lines for the text. A value of 0 means no limit.
  /// - Returns: The view with the applied text styling.
  func textVM(
    multiTextAlignment: TextAlignment,
    font: Font,
    foregroundStyle: Color,
    lineLimit: Int = 0
    
  ) -> some View {
    
    modifier(TextModifier(
      multiTextAlignment: multiTextAlignment,
      font: font,
      foregroundColor: foregroundStyle,
      lineLimit: lineLimit
    ))
    
  }
}
