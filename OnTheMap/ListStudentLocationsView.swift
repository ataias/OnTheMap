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
            // FIXME some of the URLs are not proper; what to do? maybe an alert when the user clicks on an item that has an invalid url?
            ForEach(studentLocations) { studentLocation in

                Link(destination: URL(string: "www.google.com")!) {
                    VStack(alignment: .leading) {
                        Text("\(studentLocation.firstName) \(studentLocation.lastName)")
                        Text(studentLocation.mediaURL)
                    }
                }
            }
        }
    }
}

struct ListStudentLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        ListStudentLocationsView(studentLocations: StudentLocation.sampleArray)
    }
}
