//
//  HomeView.swift
//  InspectionApp
//
//  Created by Keyur on 11/06/24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - PROPERTY
    @AppStorage("isUserLogin") var isUserLogin: Bool = false
    @State private var inspectionData: Inspection.Response?
    @State private var questionsData = [Inspection.QuestionDisplay]()
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var questionIndex: Int = 0
    @State private var showFinalScore: Bool = false
    @State private var finalScore: Double = 0.0
    @State private var showCompletedInspection: Bool = false
    @State private var showLogoutAlert: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                //HEADER
                AppNavigationView(headerTitle: "Inspection", leftButtonImage: "rectangle.portrait.and.arrow.right.fill", showLeftButton: true, showRightButton: true, navigationLeftButtonAction: {
                    showLogoutAlert.toggle()
                }, navigationRightButtonAction: {
                    showCompletedInspection.toggle()
                })
                
                if inspectionData != nil {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            //AREA
                            HomeRowView(title: "Area", subTitle: inspectionData?.inspection.area.name ?? "")
                            Divider()
                            
                            //TYPE
                            HomeRowView(title: "Inspection Type", subTitle: inspectionData?.inspection.inspectionType.name ?? "")
                            Divider()
                            
                            if questionsData.count > 0 {
                                //CATEGORY
                                HomeRowView(title: "Category", subTitle: questionsData[questionIndex].categoryName)
                                Divider()
                                
                                //QUESTIONS
                                QuestionView(question: $questionsData[questionIndex].question)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    // FOOTER VIEW
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(.white)
                            .shadow(color: .colorGray.opacity(0.5), radius: 2, x: 0, y: -3)
                            
                        HStack {
                            // PREVIOUS BUTTON
                            if questionIndex > 0 {
                                Button(action: {
                                    //Next Button Action
                                    questionIndex -= 1
                                    
                                }, label: {
                                    Text("Previous")
                                        .font(.system(size: 22, design: .rounded))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.colorGreen)
                                })
                                .padding()
                                .frame(width: 150)
                            }
                            
                            Spacer()
                            
                            // NEXT / SUBMIT BUTTON
                            Button(action: {
                                //Next Button Action
                                if questionIndex == (questionsData.count-1) {
                                    if questionsData.filter({$0.question.selectedAnswerChoiceID == nil}).isEmpty {
                                        submitInspection()
                                    } else {
                                        errorMessage = "Please answer all questions to submit inspection."
                                        showAlert.toggle()
                                    }
                                    
                                } else {
                                    UserDefaults.standard.saveQuestionData(questionsData: questionsData)
                                    questionIndex += 1
                                }
                                
                            }, label: {
                                Text((questionIndex == (questionsData.count-1)) ? "Submit" : "Next")
                                    .modifier(ButtonModifier())
                            })
                            .padding()
                            .frame(width: 120)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.colorGreen)
                            )
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 80)
                }
                else {
                    Spacer()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear(perform: {
                //call APIS
                callStartInspection()
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))

            })
            .alert(isPresented: $showLogoutAlert, content: {
                Alert(title: Text("Logout"), message: Text("Are you sure want to Logout?"), primaryButton: Alert.Button.default(Text("Yes"), action: {
                    logoutUser()
                }), secondaryButton: Alert.Button.cancel(Text("No")))

            })
            .navigationDestination(isPresented: $showFinalScore) {
                ScoreResultView(score: finalScore)
            }
            .navigationDestination(isPresented: $showCompletedInspection) {
                CompletedInspectionView()
            }
        }
    }
    
    // MARK: - FUNCTIONS
    func callStartInspection() {
        fetchInspectionData()
        
        if inspectionData == nil || questionsData.count == 0 {
            InspectionRequestService().startInspection { response, errorResponse in
                if response != nil {
                    
                    let index = UserDefaults.standard.fetchCompletedInspection().firstIndex(where: { completedInspection in
                        completedInspection.id == response!.inspection.id
                    })
                    if index != nil {
                        callStartInspection()
                    } else {
                        questionIndex = 0
                        inspectionData = response
                        questionsData = [Inspection.QuestionDisplay]()
                        if let categories = inspectionData?.inspection.survey.categories {
                            for tempCate in categories {
                                for tempQuestion in tempCate.questions {
                                    questionsData.append(Inspection.QuestionDisplay(categoryId: tempCate.id, categoryName: tempCate.name, question: tempQuestion))
                                }
                            }
                        }
                        saveInspectionData()
                    }
                } else {
                    errorMessage = errorResponse?.error ?? "Failed to get data, please try again later."
                    showAlert.toggle()
                }
            }
        }
        
    }
    
    func submitInspection() {
        var categories = inspectionData!.inspection.survey.categories
        for i in 0..<categories.count {
            for j in 0..<categories[i].questions.count {
                let index = questionsData.firstIndex { temp in
                    temp.question.id == categories[i].questions[j].id
                }
                if index != nil {
                    categories[i].questions[j].selectedAnswerChoiceID = questionsData[index!].question.selectedAnswerChoiceID
                }
            }
        }
        inspectionData!.inspection.survey.categories = categories
        print(inspectionData!.toJSON())
        InspectionRequestService().submitInspection(request: Inspection.Submit(inspection: inspectionData!.inspection)) { response, errorResponse in
            if response != nil && response == true {
                calculateFinalScore()
            } else {
                if let errorMsg = errorResponse?.error {
                    errorMessage = errorMsg
                    showAlert.toggle()
                }
            }
        }
        
        
    }
    
    func calculateFinalScore() {
        
        finalScore = 0.0
        for temp in questionsData.filter({$0.question.selectedAnswerChoiceID != -2}) {
            if temp.question.selectedAnswerChoiceID == -2 {
                print("NA")
            }
            let index = temp.question.answerChoices.firstIndex { tempAns in
                tempAns.id == temp.question.selectedAnswerChoiceID
            }
            if index != nil {
                finalScore += temp.question.answerChoices[index!].score
            }
        }
        let completedInspection = Inspection.CompletedInspection(area: inspectionData!.inspection.area, id: inspectionData!.inspection.id, inspectionType: inspectionData!.inspection.inspectionType, score: finalScore)
        UserDefaults.standard.saveCompletedInspection(data: completedInspection)
        
        showFinalScore.toggle()
        
    }
    
    func saveInspectionData() {
        UserDefaults.standard.saveInspectionData(inspectionData: inspectionData!)
        UserDefaults.standard.saveQuestionData(questionsData: questionsData)
    }
    
    func fetchInspectionData() {
        inspectionData = nil
        questionsData = [Inspection.QuestionDisplay]()
        let inspection = UserDefaults.standard.fetchInspectionData()
        let questions = UserDefaults.standard.fetchQuestionData()
        if questions.count > 0 {
            inspectionData = inspection
            questionsData = questions
        }
    }
    
    func logoutUser() {
        UserDefaults.standard.deleteInspectionData()
        UserDefaults.standard.deleteCompletedInspection()
        isUserLogin = false
    }
}

#Preview {
    HomeView()
}
