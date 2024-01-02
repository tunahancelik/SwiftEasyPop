//
//  CleanerView.swift
//  
//
//  Created by tnhn on 2.01.2024.
//

import SwiftUI

@available(iOS 14.0, *)
/// `BackgroundCleanerView` is a view modifier that sets the background of the superviews to clear.
///
/// This struct creates a transparent `UIView` and uses it to modify the background color of its superviews to clear.
/// It's useful in situations where you need to remove or clean up unwanted background colors from SwiftUI views.
struct CleanerView: UIViewRepresentable {
  
  /// Creates a `UIView` instance to be managed by SwiftUI.
  ///
  /// This method creates a transparent `UIView` and is intended to modify the background color of its superviews to clear.
  /// - Parameter context: The context in which the view is created.
  /// - Returns: A transparent `UIView` instance.
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }
  
  /// Updates the state of the specified view with new information from SwiftUI.
  ///
  /// In this implementation, this function does not perform any actions as the view is static and does not need updates.
  ///
  /// - Parameters:
  ///   - uiView: The `UIView` instance to update.
  ///   - context: The context in which the update occurs.
  func updateUIView(_ uiView: UIView, context: Context) {
    // This implementation intentionally left empty
  }
}
