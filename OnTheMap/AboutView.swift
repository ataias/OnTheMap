//
//  AboutView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
//            Link("Icons made by Freepik from Flaticon", destination: URL(string: "https://auth.udacity.com/sign-up")!)
//            + Link("Sign up!", destination: URL(string: "https://auth.udacity.com/sign-up")!)
//
            Text("Test 1")
                .onTapGesture {
                    print("Test 1")
                }
            Text("Test 2")
                .onTapGesture {
                    print("Test 2")
                }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
