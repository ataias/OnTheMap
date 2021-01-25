//
//  LoginView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            Spacer()
            Image("udacity-logo-svg-vector")
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .padding(.bottom)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Login") {
                print("FIXME")
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
        LoginView()
    }
}
