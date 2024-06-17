//
//  LoginView.swift
//  InspectionApp
//
//  Created by Keyur on 10/06/24.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - PROPERTY
    @State private var emailTxt: String = ""
    @State private var passwordTxt: String = ""
    @State private var showValidationAlert: Bool = false
    @State private var validationError: String = ""
    @State private var isLoginSuccess: Bool = false
    @AppStorage("isUserLogin") var isUserLogin: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                // HEADER
                TitleHeaderView(title: "Sign In", subTitle: "Hi! Welcome back, you've been missed")
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
                        callLoginService()
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Text("Sign In")
                            .modifier(ButtonModifier())
                        Spacer()
                    }
                })
                .modifier(FullButtonModifier())
                .padding(.vertical)
                
                
                Spacer()
                NavigationLink(
                    destination: SignupView()
                ) {
                    Text("\(Text("Don't have an account?").foregroundStyle(.colorBlack)) \(Text("Sign up").foregroundStyle(.colorGreen))")
                        .font(.system(size: 16, design: .rounded))
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .frame(minWidth: 0, maxWidth: 540)
            .alert(isPresented: $showValidationAlert, content: {
                Alert(title: Text("Error"), message: Text(validationError), dismissButton: .default(Text("OK")))

            })
            .navigationDestination(isPresented: $isLoginSuccess, destination: {
                HomeView()
            })
        }
    }
    
    
    // MARK: - FUNCTION
    func callLoginService() {
        let loginRequest = Login.Request(email: emailTxt, password: passwordTxt)
        LoginRequestService().login(request: loginRequest) { response, errorResponse in
            if response != nil && response! == true {
                debugPrint("Login Success")
                isUserLogin = true
                isLoginSuccess.toggle()
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
    LoginView()
}
