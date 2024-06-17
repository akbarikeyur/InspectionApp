//
//  TitleHeaderView.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import SwiftUI

struct TitleHeaderView: View {
    
    // MARK: - PROPERTY
    var title: String
    var subTitle: String
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(.colorBlack)
            Text(subTitle)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(.colorGray)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    TitleHeaderView(title: "SignIn", subTitle: "Hi! Welcome back, you've been missed")
}
