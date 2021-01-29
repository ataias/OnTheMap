//
//  ListStudentLocationsView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import SwiftUI

struct ListStudentLocationsView: View {
    let studentLocations: [StudentLocation]
    
    var body: some View {
        List {
            ForEach(studentLocations) { studentLocation in
                Text(studentLocation.firstName)
                + Text(studentLocation.lastName)
            }
        }
    }
}

struct ListStudentLocationsView_Previews: PreviewProvider {
    static let studentLocations: [StudentLocation] = {
        let url = Bundle.main.url(forResource: "studentLocationsDummy", withExtension: ".json")!
        let studentLocationResult = try! FileManager.read(StudentLocationResult.self, url)
        return studentLocationResult.results
    }()

    static var previews: some View {
        ListStudentLocationsView(studentLocations: studentLocations)
    }
}
