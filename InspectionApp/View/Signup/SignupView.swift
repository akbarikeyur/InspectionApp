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
    @State private var showValidationAlert: Bool = false
    @State private var showSuccessAlert: Bool = false
    @State private var validationError: String = ""
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
                        validationError = "Please enter email address"
                        showValidationAlert = true
                    }
                    else if !emailTxt.isValidEmail {
                        validationError = "Please enter valid email address"
                        showValidationAlert = true
                    }
                    else if passwordTxt.isEmpty {
                        validationError = "Please enter password"
                        showValidationAlert = true
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
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.colorGreen)
                )
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
            .padding(.horizontal, 20)
            .frame(minWidth: 0, maxWidth: 540)
            .alert(isPresented: $showValidationAlert, content: {
                Alert(title: Text("Error"), message: Text(validationError), dismissButton: .default(Text("OK")))

            })
            .alert(isPresented: $showSuccessAlert, content: {
                Alert(title: Text("Success"), message: Text("User register successfully, please login."), dismissButton: .default(Text("OK"), action: {
                    dismiss()
                }))

            })
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - FUNCTION
    func callRegisterService() {
        let signupRequest = Register.Request(email: emailTxt, password: passwordTxt)
        LoginRequestService().register(request: signupRequest) { response, errorResponse in
            if response != nil && response! == true {
                debugPrint("Login Success")
                showSuccessAlert = true
            }
            else {
                if let error = errorResponse?.error {
                    validationError = error
                    showValidationAlert = true
                }
            }
        }
    }
}

#Preview {
    SignupView()
}
