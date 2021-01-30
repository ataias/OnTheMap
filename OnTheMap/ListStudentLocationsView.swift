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
                    openURL(path: studentLocation.mediaURL)
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
    func openURL(path: String) {
        guard var urlComponents = URLComponents(string: path) else {
            showAlertFor(badURL: path)
            return
        }

        if urlComponents.scheme == nil {
            urlComponents = URLComponents()
            urlComponents.scheme = "http"
            urlComponents.host = path
        }
        let url = urlComponents.url!

        print("URL: \(url.absoluteString)")

        guard url.valid else {
            showAlertFor(badURL: path)
            return
        }

        openURL(url)
    }

    func showAlertFor(badURL: String) {
        alertMessage = "Sorry, can't open \"\(badURL)\" because that link is invalid"
        isPresented = true
    }
}

struct ListStudentLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        ListStudentLocationsView(studentLocations: StudentLocation.sampleArray)
    }
}
