//
//  Inspection.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import SwiftUI

enum Inspection {
    struct Request: Encodable {
        var inspectionId: Int
    }
    
    struct Submit: Encodable {
        let inspection: InspectionModel
    }
    
    struct Response: Codable {
        var inspection: InspectionModel
    }
    
    struct InspectionModel: Codable {
        let area: Area
        let id: Int
        let inspectionType: InspectionType
        var survey: Survey
    }
    
    // MARK: - Area
    struct Area: Codable {
        let id: Int
        let name: String
    }

    // MARK: - InspectionType
    struct InspectionType: Codable {
        let access: String
        let id: Int
        let name: String
    }

    // MARK: - Survey
    struct Survey: Codable {
        var categories: [Category]
    }

    // MARK: - Category
    struct Category: Codable, Identifiable {
        let id: Int
        let name: String
        var questions: [Question]
    }

    // MARK: - Question
    struct Question: Codable, Identifiable {
        let answerChoices: [AnswerChoice]
        let id: Int
        let name: String
        var selectedAnswerChoiceID: Int?

        enum CodingKeys: String, CodingKey {
            case answerChoices, id, name
            case selectedAnswerChoiceID = "selectedAnswerChoiceId"
        }
    }

    // MARK: - AnswerChoice
    struct AnswerChoice: Codable, Identifiable {
        let id: Int
        let name: String
        let score: Double
    }
    
    struct QuestionDisplay: Codable {
        let categoryId: Int
        let categoryName: String
        var question: Question
    }
    
    struct CompletedInspection: Codable, Identifiable {
        let area: Area
        let id: Int
        let inspectionType: InspectionType
        let score: Double
    }
}
