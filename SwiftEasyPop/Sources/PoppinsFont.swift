//
//  PoppinsFont.swift
//
//
//  Created by tnhn on 2.01.2024.
//

import SwiftUI

/// An enumeration representing the different weights of the Poppins font.
///
/// - `regular`: The regular weight of the Poppins font.
/// - `medium`: The medium weight of the Poppins font.
/// - `semiBold`: The semi-bold weight of the Poppins font.
/// - `bold`: The bold weight of the Poppins font.
public enum Poppins: String, CaseIterable {
  case regular = "Poppins-Regular"
  case medium = "Poppins-Medium"
  case semiBold = "Poppins-SemiBold"
  case bold = "Poppins-Bold"
}

@available(iOS 14.0, *)
extension Font {
  /// Creates a font with the specified Poppins style and size.
  ///
  /// - Parameters:
  ///   - poppins: The Poppins font weight to use.
  ///   - size: The size of the font.
  /// - Returns: A `Font` object with the specified Poppins style and size.
  public static func poppins(_ poppins: Poppins, size: CGFloat) -> Font {
    return .custom(poppins.rawValue, size: size, relativeTo: .body)
  }
}

public struct PoppinsFont {
  /// A utility struct for registering Poppins fonts.
  ///
  /// Use `registerFonts` to load and register all Poppins font weights contained in the app bundle.
  public static func registerFonts(){
    Poppins.allCases.forEach {
      registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
    }
  }
  
  /// Registers a font with the given bundle, font name, and extension.
  ///
  /// - Parameters:
  ///   - bundle: The bundle containing the font file.
  ///   - fontName: The name of the font file.
  ///   - fontExtension: The extension of the font file.
  fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension), let fontDataProvider = CGDataProvider(url: fontURL as CFURL), let font = CGFont(fontDataProvider) else {
      fatalError("couldn't create font from filename")
    }
    
    var error: Unmanaged<CFError>?
    CTFontManagerRegisterGraphicsFont(font, &error)
  }
}
