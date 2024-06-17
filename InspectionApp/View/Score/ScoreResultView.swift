//
//  ScoreResultView.swift
//  InspectionApp
//
//  Created by Keyur on 13/06/24.
//

import SwiftUI

struct ScoreResultView: View {
    // MARK: - BODY
    @Environment(\.dismiss) var dismiss
    var score: Double = 0.0
    
    
    // MARK: - PROPERTY
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("The Inspection has been completed.")
                    .font(.system(size: 20,  design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.colorBlack)
                    .multilineTextAlignment(.center)
                
                Text("Your final score is")
                    .font(.system(size: 20,  design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.colorGray)
                    .padding()
                
                Text("\(score, specifier: "%.2f")")
                    .font(.system(size: 80,  design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.colorGreen)
                
                Button(action: {
                    deleteInspectionData()
                    dismiss()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Back to Home")
                            .modifier(ButtonModifier())
                        Spacer()
                    }
                })
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.colorGreen)
                )
                .padding(.horizontal, 50)
            }
            .frame(minWidth: 0, maxWidth: 540)
            .padding(.horizontal)
            .toolbar(.hidden, for: .navigationBar)
        }
        
    }
    
    // MARK: - FUNCTION
    func deleteInspectionData() {
        UserDefaults.standard.deleteInspectionData()
    }
}

#Preview {
    ScoreResultView(score: 0.0)
}
