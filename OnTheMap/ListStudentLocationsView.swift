//
//  ListStudentLocationsView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import SwiftUI

struct ListStudentLocationsView: View {
    // MARK: - Parameters
    let studentLocations: [StudentLocation]

    // MARK: - State, Environment and computed properties
    @State private var isPresented = false
    @State private var alertMessage = ""
    @Environment(\.openURL) var openURL

    // MARK: - body
    var body: some View {
        List {
            ForEach(studentLocations) { studentLocation in

                Button(action: {
                    var urlComponents = URLComponents(string: studentLocation.mediaURL)!
                    if urlComponents.scheme == nil {
                        urlComponents.scheme = "http"
                    }
                    let url = urlComponents.url!
                    guard url.valid else {
                        alertMessage = "Sorry, can't open \"\(studentLocation.mediaURL)\" because that link is invalid"
                        isPresented = true
                        return
                    }

                    openURL(url)
                }, label: {
                    VStack(alignment: .leading) {
                        Text("\(studentLocation.firstName) \(studentLocation.lastName)")
                        Text(studentLocation.mediaURL)
                    }
                })

            }
            .alert(isPresented: $isPresented, content: {
                Alert(title: Text("Invalid URL"), message: Text(alertMessage), dismissButton: Alert.Button.default(Text("OK")))
            })
        }
    }

    // MARK: - methods

}

struct ListStudentLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        ListStudentLocationsView(studentLocations: StudentLocation.sampleArray)
    }
}
