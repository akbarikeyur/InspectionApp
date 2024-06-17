//
//  InspectionListView.swift
//  InspectionApp
//
//  Created by Keyur on 14/06/24.
//

import SwiftUI

struct InspectionListView: View {
    
    // MARK: - PROPERTY
    var inspection: Inspection.CompletedInspection
    
    // MARK: - BODY
    var body: some View {
        VStack {
            //AREA
            HomeRowView(title: "Area", subTitle: inspection.area.name)
            Divider()
            
            //TYPE
            HomeRowView(title: "Inspection Type", subTitle: inspection.inspectionType.name)
            Divider()
            
            //TYPE
            HomeRowView(title: "Inspection Score", subTitle: "\(inspection.score)")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .colorGray.opacity(0.5), radius: 3, x: 0, y: 2)
        )
        .padding(.vertical)
        
    }
}

struct InspectionListView_Previews: PreviewProvider {
    
    @State static var inspection: Inspection.CompletedInspection = Inspection.CompletedInspection(area: Inspection.Area(id: 1, name: "ICU"), id: 1, inspectionType: Inspection.InspectionType(access: "write", id: 1, name: "Clinical"), score: 1.0)
    
    static var previews: some View {
        InspectionListView(inspection: inspection)
    }
}
