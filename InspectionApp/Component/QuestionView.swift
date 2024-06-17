//
//  QuestionView.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import SwiftUI

struct QuestionView: View {
    
    // MARK: - PROPERTY
    @Binding var question: Inspection.Question
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Que. \(question.name)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .padding(.vertical)
            
            ForEach(question.answerChoices) { item in
                AnswerView(
                    isSelected: (question.selectedAnswerChoiceID != nil && question.selectedAnswerChoiceID! == item.id),
                    title: item.name
                )
                .onTapGesture {
                    //select answer
                    question.selectedAnswerChoiceID = item.id
                }
            }
            AnswerView(
                isSelected: (question.selectedAnswerChoiceID != nil && question.selectedAnswerChoiceID! == -2),
                title: "Not Applicable"
            )
            .onTapGesture {
                //select answer
                question.selectedAnswerChoiceID = -2
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    
    @State static var question: Inspection.Question = Inspection.Question(answerChoices: [Inspection.AnswerChoice(id: 1, name: "Everyday", score: 1.0)], id: 1, name: "How often is the floor cleaned?", selectedAnswerChoiceID: nil)
    
    static var previews: some View {
        QuestionView(question: $question)
    }
}
