//
//  OnTheMapApp.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 25/01/21.
//

import SwiftUI
import PartialSheet

@main
struct OnTheMapApp: App {
    @StateObject var model = OnTheMapModel()
    let sheetManager: PartialSheetManager = PartialSheetManager()

    var body: some Scene {
        WindowGroup {
            MainView<OnTheMapModel>(authenticated: model.authenticated, studentLocations: model.studentLocations)
                .environmentObject(model)
                .environmentObject(sheetManager)
                .onAppear(perform: {
                    model.getStudentLocations(limit: 100, skip: 0, orderBy: .ascending(.createdAt))
                })
        }
    }
}
