//
//  AnswerView.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import SwiftUI

struct AnswerView: View {
    
    // MARK: - PROPERTY
    var isSelected: Bool
    var title: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "smallcircle.fill.circle" : "circle")
                .font(.system(size: 25, design: .rounded))
                .foregroundStyle(.colorBlack)
                .frame(height: 40)
            Text(title)
                .font(.system(size: 18, design: .rounded))
                .foregroundStyle(.colorBlack)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

#Preview {
    AnswerView(isSelected: false, title: "Working locally in Scratch Pad.")
}
