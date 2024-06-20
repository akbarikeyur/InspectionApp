//
//  SignupView.swift
//  InspectionApp
//
//  Created by Keyur on 10/06/24.
//

import SwiftUI

struct SignupView: View {
    
    // MARK: - PROPERTY
    @State private var emailTxt: String = ""
    @State private var passwordTxt: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @Environment(\.dismiss) var dismiss
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                // HEADER
                TitleHeaderView(title: "Create Account", subTitle: "Fill your information below")
                    .padding(.bottom, 50)
                // TEXTFIELD
                VStack(spacing: 20) {
                    // BODY
                    VStack(alignment: .leading, content: {
                        Text("Email")
                            .font(.system(size: 16, design: .rounded))
                        TextField("", text: $emailTxt)
                            .textInputAutocapitalization(.never)
                            .modifier(TextFieldModifier())
                            .keyboardType(.emailAddress)
                    })
                    
                    VStack(alignment: .leading, content: {
                        Text("Password")
                            .font(.system(size: 16, design: .rounded))
                        SecureField("", text: $passwordTxt)
                            .modifier(TextFieldModifier())
                    })
                }
                
                //BUTTON
                Button(action: {
                    //login button action
                    hideKeyboard()
                    if emailTxt.isEmpty {
                        alertTitle = "Error"
                        alertMessage = "Please enter email address"
                        showAlert = true
                    }
                    else if !emailTxt.isValidEmail {
                        alertTitle = "Error"
                        alertMessage = "Please enter valid email address"
                        showAlert = true
                    }
                    else if passwordTxt.isEmpty {
                        alertTitle = "Error"
                        alertMessage = "Please enter password"
                        showAlert = true
                    }
                    else {
                        callRegisterService()
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Text("Sign Up")
                            .modifier(ButtonModifier())
                        Spacer()
                    }
                })
                .modifier(FullButtonModifier())
                .padding(.vertical)
                
                Spacer()
                
                Button(action: {
                    // signup button action
                    hideKeyboard()
                    dismiss()
                }, label: {
                    Text("\(Text("Already have an account?").foregroundStyle(.colorBlack)) \(Text("Sign In").foregroundStyle(.colorGreen))")
                        .font(.system(size: 16, design: .rounded))
                        .fontWeight(.semibold)
                        
                })
                .padding(.bottom, 20)
            }
            .navigationBarBackButtonHidden()
            .padding(.horizontal, 20)
            .frame(minWidth: 0, maxWidth: 540)
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))

            })
        }
    }
    
    // MARK: - FUNCTION
    func callRegisterService() {
        let signupRequest = Register.Request(email: emailTxt, password: passwordTxt)
        LoginRequestService().register(request: signupRequest) { response, errorResponse in
            if response != nil && response! == true {
                debugPrint("Login Success")
                alertTitle = "Success"
                alertMessage = "User register successfully, please login."
                showAlert = true
            }
            else {
                if let error = errorResponse?.error {
                    alertTitle = "Error"
                    alertMessage = error
                    showAlert = true
                }
            }
        }
    }
}

#Preview {
    SignupView()
}
