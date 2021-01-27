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
    @EnvironmentObject var client: T

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
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .disableAutocorrection(true)
            Button("Login") {
                client.login(username: email, password: password)
            }
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView<MockApiClient>()
            .environmentObject(MockApiClient())
    }
}
