//
//  ContentView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI

struct MainView: View {
    @State private var isPresented = false
    var body: some View {
        NavigationView {
            LoginView()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView()
        }
    }
}
