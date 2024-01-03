//
//  BlurView.swift
//  
//
//  Created by tnhn on 2.01.2024.
//

import SwiftUI

//MARK: - BackgroundBlurView
@available(iOS 14.0, *)
/// `BackgroundBlurView` creates a blur effect overlay in a SwiftUI view.
///
/// This view is a SwiftUI wrapper around the `UIVisualEffectView` from UIKit to create a light blur effect.
/// It can be used as a background in SwiftUI views to blur the content underneath.
struct BlurView: UIViewRepresentable {
  
  /// Creates a `UIView` instance to be managed by SwiftUI.
  ///
  /// - Parameter context: The context in which the view is created.
  /// - Returns: A `UIVisualEffectView` configured with a light blur effect.
  func makeUIView(context: Context) -> UIView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }
  
  /// Updates the state of the specified view with new information from SwiftUI.
  ///
  /// In this implementation, this function does not perform any actions.
  ///
  /// - Parameters:
  ///   - uiView: The `UIView` instance to update.
  ///   - context: The context in which the update occurs.
  func updateUIView(_ uiView: UIView, context: Context) {}
}
