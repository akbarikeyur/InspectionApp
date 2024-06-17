//
//  HomeRowView.swift
//  InspectionApp
//
//  Created by Keyur on 13/06/24.
//

import SwiftUI

struct HomeRowView: View {
    // MARK: - PROPERTY
    var title: String
    var subTitle: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.regular)
                .foregroundStyle(.colorGray)
            Spacer()
            Text(subTitle)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundStyle(.colorBlack)
        }
    }
}

#Preview {
    HomeRowView(title: "Title", subTitle: "Subtitle")
}
