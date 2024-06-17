//
//  TextFieldModifier.swift
//  InspectionApp
//
//  Created by Keyur on 13/06/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, design: .rounded))
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 5
                )
                .fill(Color.clear)
            )
            .overlay(
                RoundedRectangle(
                    cornerRadius: 5
                )
                .stroke(lineWidth: 1)
            )
            .foregroundColor(.colorGray)
    }
}
