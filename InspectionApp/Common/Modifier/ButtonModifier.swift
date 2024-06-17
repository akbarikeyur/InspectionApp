//
//  ButtonModifier.swift
//  InspectionApp
//
//  Created by Keyur on 13/06/24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22, design: .rounded))
            .fontWeight(.semibold)
            .foregroundStyle(.white)
    }
}


struct FullButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.colorGreen)
            )
    }
}
