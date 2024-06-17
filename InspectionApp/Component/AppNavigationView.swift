//
//  AppNavigationView.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import SwiftUI

struct AppNavigationView: View {
    // MARK: - PROPERTY
    var headerTitle: String
    var leftButtonImage: String
    var showLeftButton: Bool
    var showRightButton: Bool
    var navigationLeftButtonAction: () -> Void
    var navigationRightButtonAction: () -> Void
    
    // MARK: - BODY
    var body: some View {
        
        HStack {
            Button(action: {
                self.navigationLeftButtonAction()
            }, label: {
                Image(systemName: leftButtonImage)
                    .font(.system(size: 30, design: .rounded))
                    .foregroundStyle(.white)
            })
            .padding(.leading)
            .opacity(showLeftButton ? 1 : 0)
            Spacer()
            
            Text(headerTitle)
                .font(.system(size: 25, design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(10)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            Button(action: {
                self.navigationRightButtonAction()
            }, label: {
                Image(systemName: "list.bullet.circle.fill")
                    .font(.system(size: 30, design: .rounded))
                    .foregroundStyle(.white)
            })
            .padding(.trailing)
            .opacity(showRightButton ? 1 : 0)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 64)
        .background(
            .colorGreen
        )
    }
}

#Preview {
    AppNavigationView(headerTitle: "Completed Inspection", leftButtonImage: "chevron.left.circle.fill", showLeftButton: true, showRightButton: true, navigationLeftButtonAction: {}, navigationRightButtonAction: {})
}
