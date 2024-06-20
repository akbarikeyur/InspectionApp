//
//  RestAPITest.swift
//  InspectionAppTests
//
//  Created by Amisha on 20/06/24.
//

import XCTest
@testable import InspectionApp

final class RestAPITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - LOGIN API
    func testLoginSuccess() {
        // Given
        let email = "keyur@gmail.com"
        let password = "12345"
        let expectation = self.expectation(description: "Login success")

        // When
        LoginRequestService().login(request: Login.Request(email: email, password: password)) { response, errorResponse in
            // Then
            XCTAssertTrue(response ?? false)
            XCTAssertNil(errorResponse?.error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLoginFailure() {
        // Given
        let email = "wrong@email.com"
        let password = "wrongpassword"
        let expectation = self.expectation(description: "Login failure")

        // When
        LoginRequestService().login(request: Login.Request(email: email, password: password)) { response, errorResponse in
            // Then
            XCTAssertFalse(response ?? false)
            XCTAssertNotNil(errorResponse?.error)
            XCTAssertEqual(errorResponse?.error, "Invalid user or password")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    // MARK: - INSPECTION API
    func testSubmitInspection() {
        // Given
        let inspection = Inspection.InspectionModel(
            area: Inspection.Area(id: 1, name: "Emergency ICU"),
            id: 3,
            inspectionType: Inspection.InspectionType(access: "write", id: 1, name: "Clinical"), 
            survey: Inspection.Survey(
                categories: [
                    Inspection.Category(id: 1, name: "Drugs", questions: [
                        Inspection.Question(
                            answerChoices: [
                                Inspection.AnswerChoice(id: 1, name: "Yes", score: 1.0),
                                Inspection.AnswerChoice(id: 2, name: "No", score: 0.0),
                                Inspection.AnswerChoice(id: -1, name: "N/A", score: 0.0)
                            ],
                            id: 1, name: "Is the drugs trolley locked?", selectedAnswerChoiceID: 1),
                        Inspection.Question(
                            answerChoices: [
                                Inspection.AnswerChoice(id: 3, name: "Everyday", score: 1.0),
                                Inspection.AnswerChoice(id: 4, name: "Every two days", score: 0.5),
                                Inspection.AnswerChoice(id: 5, name: "Every week", score: 0.0)
                            ],
                            id: 2, name: "How often is the floor cleaned?", selectedAnswerChoiceID: 3)
                    ]),
                    Inspection.Category(id: 2, name: "Overall Impressions", questions: [
                        Inspection.Question(
                            answerChoices: [
                                Inspection.AnswerChoice(id: 6, name: "1-2", score: 0.5),
                                Inspection.AnswerChoice(id: 7, name: "3-6", score: 0.5),
                                Inspection.AnswerChoice(id: 8, name: "6+", score: 0.5),
                                Inspection.AnswerChoice(id: -1, name: "N/A", score: 0.0)
                            ],
                            id: 3, name: "How many staff members are present in the ward?", selectedAnswerChoiceID: 6),
                        Inspection.Question(
                            answerChoices: [
                                Inspection.AnswerChoice(id: 9, name: "Very often", score: 0.5),
                                Inspection.AnswerChoice(id: 10, name: "Often", score: 0.5),
                                Inspection.AnswerChoice(id: 11, name: "Not very often", score: 0.5),
                                Inspection.AnswerChoice(id: 12, name: "Never", score: 0.5)
                            ],
                            id: 4, name: "How often are the area inspections carried?", selectedAnswerChoiceID: 10)
                    ])
                ]))
        
        
        let expectation = self.expectation(description: "Inspection submit successfully")

        // When
        InspectionRequestService().submitInspection(request: Inspection.Submit(inspection: inspection)) { response, errorResponse in
            
            // Then
            XCTAssertTrue(response ?? false)
            XCTAssertNil(errorResponse?.error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
