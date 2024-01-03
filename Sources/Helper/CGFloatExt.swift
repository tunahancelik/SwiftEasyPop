//
//  CGFloatExt.swift
//
//
//  Created by tnhn on 2.01.2024.
//

import SwiftUI

extension CGFloat{
  /// Initializes a CGFloat value scaled for a specific width, considering the device type (iPad or iPhone).
  ///
  /// On iPads, it returns the original width value. On iPhones, if a height is provided, it scales the width based on the aspect ratio.
  /// Otherwise, it scales the width based on the screen width of the iPhone.
  ///
  /// - Parameters:
  ///   - width: The original width to be scaled.
  ///   - height: An optional height to maintain aspect ratio on iPhones. Defaults to 0, which ignores aspect ratio.
  init(width: CGFloat, for height: CGFloat = 0){
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.init(width)
    }else{
      if height > 0{
        self.init(.init(height: height) * width / height)
      }else{
        self.init(width / 414 * UIScreen.main.bounds.size.width)
      }
    }
  }
  
  /// Initializes a CGFloat value scaled for a specific height, considering the device type (iPad or iPhone).
  ///
  /// On iPads, it returns the original height value. On iPhones, if a width is provided, it scales the height based on the aspect ratio.
  /// Otherwise, it scales the height based on the screen height of the iPhone.
  ///
  /// - Parameters:
  ///   - height: The original height to be scaled.
  ///   - width: An optional width to maintain aspect ratio on iPhones. Defaults to 0, which ignores aspect ratio.
  init(height: CGFloat, for width: CGFloat = 0){
    if UIDevice.current.userInterfaceIdiom == .pad {
      self.init(height)
    }else{
      if width > 0{
        self.init(.init(width: width) * height / width)
      }else{
        self.init(height / 896 * UIScreen.main.bounds.size.height)
      }
    }
  }
}
