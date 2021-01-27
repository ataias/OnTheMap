//
//  OnTheMapApp.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI

@main
struct OnTheMapApp: App {
    @StateObject var model = OnTheMapModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear(perform: {
                    model.postSession()
                })
        }
    }
}
