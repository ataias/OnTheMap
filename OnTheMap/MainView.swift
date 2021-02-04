//
//  ContentView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI
import PartialSheet

struct MainView<T: ApiClient>: View {
    @State private var isPresented = false
    let authenticated: Bool
    let studentLocations: [StudentInformation]
    var body: some View {
        NavigationView {
            if authenticated {
                MapTabView<T>(studentLocations: studentLocations)
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
            MainView<MockApiClient>(authenticated: false, studentLocations: StudentInformation.sampleArray)
            MainView<MockApiClient>(authenticated: true, studentLocations: StudentInformation.sampleArray)
        }
        .environmentObject(MockApiClient())
        .environmentObject(PartialSheetManager())
    }
}
