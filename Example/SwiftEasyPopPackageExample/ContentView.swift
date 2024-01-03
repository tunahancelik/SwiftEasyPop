//
//  ContentView.swift
//  SwiftEasyPopPackageExample
//
//  Created by tnhn on 2.01.2024.
//

import SwiftUI
import SwiftEasyPop

struct ContentView: View {
  /// State variables to control the presentation of the alert and toast
  @State private var toast: EasyToastView? = nil
  @State private var presentAlert: Bool = false
  
  var body: some View {
    ZStack {
      VStack {
        // Button to show an alert
        Button("Show Alert") {
          presentAlert = true
        }
        .buttonStyle(.borderedProminent)
        
        // Button to show a toast
        Button("Show Toast") {
          /*
           Examples Toast Messages
           */
          
          //                          toast = EasyToastView(type: .success, title: "Success", message: "This is success message", duration: 6.0)
          
          toast = EasyToastView(type: .custom, title: "Custom", message: "This is custom message",iconName: "lamp.desk",customColor: .indigo, duration: 6.0)
          //          toast = EasyToastView(type: .error, title: "Error", message: "This is error message", duration: 6.0)
          //          toast = EasyToastView(type: .info, title: "Info", message: "This is info message", duration: 6.0)
          //                            toast = EasyToastView(type: .warning, title: "Warning", message: "This is warning message")
        }
        .buttonStyle(.borderedProminent)
        
      }
      .padding()
      
      // Presenting a custom alert
      if presentAlert{
        EasyAlertPop(presentAlert: $presentAlert, alertType: .constant(.oneButton(title: "Do you want to delete?", message: "If you delete this file then you won’t please again check everything"))){ withAnimation{  presentAlert.toggle() }
        } rightButtonAction: { withAnimation{ presentAlert.toggle() } }
        
        //        EasyAlertPop(presentAlert: $presentAlert, alertType: .constant(.twoButton(title: "Do you want to delete?", message: "If you delete this file then you won’t please again check everything", leftButtonText: "Cancel", rightButtonText: "Delete"))){
        //          withAnimation{
        //            presentAlert.toggle()
        //          }
        //        } rightButtonAction: {
        //          withAnimation{
        //            presentAlert.toggle()
        //          }
        //        }
      }
    }
    // Applying the custom toast view modifier to the ZStack
    .toastView(toast: $toast)
  }
}

#Preview {
  ContentView()
}
