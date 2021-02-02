//
//  LoginView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI

struct LoginView<T: ApiClient>: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggingIn = false
    @EnvironmentObject var client: T

    private var isFilled: Bool {
        email.count != 0 && password.count != 0
    }

    var body: some View {
        VStack {
            Spacer()
            Image("udacity-logo-svg-vector")
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .padding(.bottom)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password) {
                if isFilled {
                    login()
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            StyledButton(text: "Login") {
                login()
            }
            .padding(.top)
            .disabled(!isFilled || isLoggingIn)
            
            ProgressView()
                .hidden(if: !isLoggingIn)
            Spacer()
            HStack {
                Text("Don't have an account?")
                Link("Sign up!", destination: URL(string: "https://auth.udacity.com/sign-up")!)
            }
            .font(.body)
        }
        .padding([.leading, .trailing])
        .font(.title2)
    }

    func login() {
        isLoggingIn = true
        client.login(
            username: email,
            password: password) {
            isLoggingIn = false
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView<MockApiClient>()
            .environmentObject(MockApiClient())
    }
}
