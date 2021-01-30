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
            MainView<OnTheMapModel>(authenticated: model.authenticated, studentLocations: model.studentLocations)
                .environmentObject(model)
                .onAppear(perform: {
                    model.getStudentLocations(limit: 100, skip: 0, orderBy: .ascending(.createdAt))
                })
        }
    }
}
