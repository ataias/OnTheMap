//
//  ContentView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI

struct MainView<T: ApiClient>: View {
    @State private var isPresented = false
    let authenticated: Bool
    var body: some View {
        NavigationView {
            if authenticated {
                Text("Hello")
            } else {
                LoginView<T>()
                    .sheet(isPresented: $isPresented, content: {
                        NavigationView {
                            AboutView()
                        }
                    })
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isPresented = true
                            }) {
                                Text("About")
                            }
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView<MockApiClient>(authenticated: false)
            MainView<MockApiClient>(authenticated: true)
        }
            .environmentObject(MockApiClient())
    }
}
