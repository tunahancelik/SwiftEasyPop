//
//  EasyToastView.swift
//  
//
//  Created by tnhn on 2.01.2024.
//

import SwiftUI

//MARK: - Custom Toast View
@available(iOS 14.0, *)
/// A SwiftUI view for displaying customizable toast messages.
///
/// This view creates a toast message with a configurable style, title, message, and a dismiss button.
/// The toast style is determined by `CustomToastStyle`, which affects the icon and theme color.
///
/// - Parameters:
///   - toastType: The style of the toast, defined in `CustomToastStyle`.
///   - toastTitle: The title text of the toast.
///   - toastMessage: The message text of the toast.
///   - onCancelTapped: A closure that is executed when the dismiss button is tapped.
public struct CustomToastView: View {
  
  @Environment(\.colorScheme) private var colorScheme: ColorScheme
  public let toastType: CustomToastStyle
  public let toastTitle: String
  public let toastMessage: String
  public let onCancelTapped: (() -> Void)
  
  @available(iOS 14.0, *)
  public var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: toastTitle.isEmpty || toastMessage.isEmpty ? .center : .top) {
        Image(systemName: toastType.iconFileName)
          .foregroundColor(toastType.themeColor)
        
        VStack(alignment: .leading, spacing: .init(height: toastTitle.isEmpty || toastMessage.isEmpty ? 0 : 5)) {
          
          if !toastTitle.isEmpty {
            Text(toastTitle)
              .lineLimit(1)
              .textVM(multiTextAlignment: .leading, font: .poppins(.semiBold, size: .init(height: 16)), foregroundStyle: colorScheme == .light ? Color(hexString: "#232323") : Color(hexString: "#F2F2F2"))
          }
          
          if !toastMessage.isEmpty {
            Text(toastMessage)
              .textVM(multiTextAlignment: .leading, font: .poppins(.regular, size: .init(height: 14)), foregroundStyle: colorScheme == .light ? Color(hexString: "#232323") : Color(hexString: "#F2F2F2"))
              .lineLimit(2)
          }
          
        }
        
        Spacer(minLength: .init(height: 10))
        
        Button { /// dismiss button
          onCancelTapped()
        } label: {
          Image(systemName: "xmark")
            .foregroundColor(colorScheme == .light ? Color(hexString: "#232323") : Color(hexString: "#F2F2F2"))
        }
      }
      .padding()
    }
    .background(colorScheme == .light ? Color(hexString: "#F2F2F2") : Color(hexString: "#232323"))
    .overlay(
      Rectangle()
        .fill(toastType.themeColor)
        .frame(width: toastTitle.isEmpty || toastMessage.isEmpty ? 0 : 6)
        .clipped()
      , alignment: .leading
    )
    .frame(minWidth: 0, maxWidth: .infinity)
    .cornerRadius(.init(height: 10))
    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
    .padding(.horizontal, .init(width: 20))
  }
  
}

//MARK: - Enum Model
@available(iOS 14.0, *)
/// `ToastView` is a customizable view component for displaying toast messages.
/// It supports custom styles, icons, colors, and fonts.
///
/// Use the `init` method to create a new instance with custom configurations.
public struct EasyToastView: Equatable {
  var type: CustomToastStyle
  var title:          String
  var message:        String
  var customIconName: String?
  var customColor:    Color?
  var duration:       Double = 3
  var yOffset:        Double = -30
  
  /// Initializes a new ToastView with specified properties.
  ///
  /// - Parameters:
  /// - type: The style of the toast, defined in `CustomToastStyle`.
  /// - title: The title of the toast message.
  /// - message: The message body of the toast.
  /// - iconName: Optional custom icon name. If not provided, default icon will be used based on `type`.
  /// - customColor: Optional custom color. If not provided, default color will be used based on `type`.
  /// - duration: The duration for which the toast is visible. Default is 3 seconds.
  /// - yOffset: The vertical offset for the toast position. Default is -30.
  ///
  /// - Note: If `type` is set to `.custom`, you can provide custom values for `iconName`, `customFontName`, and `customColor`.
  public init(type: CustomToastStyle, title: String, message: String, iconName: String? = nil, customColor: Color? = nil, duration: Double = 3.0, yOffset: Double = -30.0) {
    self.type =     type
    self.title =    title
    self.message =  message
    self.duration = duration
    self.yOffset =  yOffset
    
    
    if type == .custom {
      CustomToastStyle.setCustomColor(customColor ?? .clear)
      CustomToastStyle.setCustomIconName(iconName ?? "")
    }
    
  }
}

//MARK: - Enum
@available(iOS 14.0, *)
/// Enum representing different styles for custom toast messages.
///
/// This enum includes several predefined styles (`error`, `warning`, `success`, `info`) and a `custom` style.
/// The `custom` style allows for setting a custom color and icon name.
public enum CustomToastStyle {
  case error
  case warning
  case success
  case info
  case custom
  
  static var customColor: Color = Color.clear // Default Value
  static var customIconName: String = "" // Default Value
  
  /// Sets the custom color for the `custom` toast style.
  ///
  /// - Parameter color: The color to set for the custom style.
  static func setCustomColor(_ color: Color) {
    customColor = color
  }
  
  /// Sets the custom icon name for the `custom` toast style.
  ///
  /// - Parameter iconName: The icon name to set for the custom style.
  
  static func setCustomIconName(_ iconName: String) {
    customIconName = iconName
  }
}

@available(iOS 14.0, *)
extension CustomToastStyle {
  /// Returns the theme color associated with the toast style.
  ///
  /// For predefined styles, this will return specific colors.
  /// For the `custom` style, it will return the color set by `setCustomColor`.
  var themeColor: Color {
    switch self {
    case .error:
      return Color.red
    case .warning:
      return Color.orange
    case .success:
      return Color.green
    case .info:
      return Color.blue
    case .custom:
      return CustomToastStyle.customColor
      
    }
  }
  /// Returns the icon file name associated with the toast style.
  ///
  /// For predefined styles, this will return specific icons.
  /// For the `custom` style, it will return the icon name set by `setCustomIconName`.
  var iconFileName: String {
    switch self {
    case .info: return "info.circle.fill"
    case .warning: return "exclamationmark.triangle.fill"
    case .success: return "checkmark.circle.fill"
    case .error: return "xmark.circle.fill"
    case .custom:
      return CustomToastStyle.customIconName
    }
  }
}

//MARK: - Custom Toast Modifier
@available(iOS 14.0, *)
/// A `ViewModifier` for presenting custom toast messages on top of a view.
///
/// This modifier overlays a `CustomToastView` on the content. The toast can be dismissed either automatically after a certain duration or by user interaction.

struct CustomToastModifier: ViewModifier {
  @Binding var toast: EasyToastView?
  @State private var workItem: DispatchWorkItem?
  
  /// Modifies the body of the content to include a toast overlay.
  ///
  /// - Parameter content: The content view that the modifier is applied to.
  /// - Returns: A view that has been modified to include a toast overlay.
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(
        ZStack {
          mainToastView()
            .offset(y: toast?.yOffset ?? -30)
        }.animation(.spring(), value: toast)
      )
      .onChange(of: toast) { value in
        showToast()
      }
  }
  
  /// Creates the view for the main toast.
  ///
  /// - Returns: A view representing the actual toast message, if any.
  @ViewBuilder func mainToastView() -> some View {
    if let toast = toast {
      VStack {
        Spacer()
        CustomToastView(
          toastType: toast.type,
          toastTitle: toast.title,
          toastMessage: toast.message, onCancelTapped: {
            dismissToast()
          })
      }
      .transition(.move(edge: .bottom))
    }
  }
  
  /// Triggers the presentation of the toast message with optional auto dismissal.
  ///
  /// Presents the toast and sets up a timer for automatic dismissal if a duration is specified.
  private func showToast() {
    guard let toast = toast else { return }
    
    UIImpactFeedbackGenerator(style: .light).impactOccurred()
    
    if toast.duration > 0 {
      workItem?.cancel()
      
      let task = DispatchWorkItem {
        dismissToast()
      }
      
      workItem = task
      DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
    }
  }
  
  /// Dismisses the current toast message.
  ///
  /// Resets the `toast` binding to `nil` and cancels any dismissal timer.
  private func dismissToast() {
    withAnimation {
      toast = nil
    }
    
    workItem?.cancel()
    workItem = nil
  }
}

//MARK: - View Extension
@available(iOS 14.0, *)
public extension View {
  /// Adds a toast view modifier to the view.
  ///
  /// - Parameter toast: A binding to an optional `EasyToastView` that controls the toast's presentation.
  /// - Returns: The modified view that can present a custom toast message.
  func toastView(toast: Binding<EasyToastView?>) -> some View {
    self.modifier(CustomToastModifier(toast: toast))
  }
}
