//
//  CompletedInspectionView.swift
//  InspectionApp
//
//  Created by Keyur on 14/06/24.
//

import SwiftUI

struct CompletedInspectionView: View {
    // MARK: - PROPERTY
    
    var completedInspectionData: [Inspection.CompletedInspection] = UserDefaults.standard.fetchCompletedInspection()
    @Environment(\.dismiss) var dismiss
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
            VStack {
                //HEADER
                AppNavigationView(headerTitle: "Completed Inspection", leftButtonImage: "chevron.left.circle.fill", showLeftButton: true, showRightButton: false, navigationLeftButtonAction: {
                    dismiss()
                }, navigationRightButtonAction: {})
                if completedInspectionData.count > 0 {
                    List {
                        VStack {
                            ForEach(completedInspectionData) { item in
                                InspectionListView(inspection: item)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                }
                else {
                    Spacer()
                    VStack {
                        Text("You have not completed any inspection,\nplease start inspection.")
                            .font(.system(size: 18, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            dismiss()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Start Inspection")
                                    .modifier(ButtonModifier())
                                Spacer()
                            }
                        })
                        .modifier(FullButtonModifier())
                        .frame(width: 250)
                        .padding(.vertical)
                    }
                }
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct CompletedInspectionView_Previews: PreviewProvider {
    
    @State static var inspection: Inspection.CompletedInspection = Inspection.CompletedInspection(area: Inspection.Area(id: 1, name: "ICU"), id: 1, inspectionType: Inspection.InspectionType(access: "write", id: 1, name: "Clinical"), score: 1.0)
    
    static var previews: some View {
        CompletedInspectionView()
    }
}
