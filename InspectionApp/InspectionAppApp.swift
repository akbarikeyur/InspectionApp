//
//  InspectionAppApp.swift
//  InspectionApp
//
//  Created by Keyur on 10/06/24.
//

import SwiftUI

@main
struct InspectionAppApp: App {
    @AppStorage("isUserLogin") var isUserLogin: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isUserLogin {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
