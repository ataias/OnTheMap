//
//  ListStudentLocationsView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import SwiftUI

struct ListStudentLocationsView: View {
    // MARK: - Parameters
    let studentLocations: [StudentInformation]

    // MARK: - State, Environment and computed properties
    @State private var isPresented = false
    @State private var alertInfo: AlertInfo!
    @Environment(\.openURL) var openURL

    // MARK: - body
    var body: some View {
        List {
            ForEach(studentLocations) { studentLocation in

                Button(action: {
                    openURL(path: studentLocation.mediaURL)
                }, label: {

                    HStack {
                        Image(systemName: "pin")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("\(studentLocation.firstName) \(studentLocation.lastName)")
                            Text(studentLocation.mediaURL)
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                        }
                    }
                })

            }
            .alert(isPresented: $isPresented, content: {
                Alert(title: Text(alertInfo.title), message: Text(alertInfo.message), dismissButton: Alert.Button.default(Text("OK")))
            })
        }
    }

    // MARK: - methods
    func openURL(path: String) {
        if let url = URL(from: path, withDefaultScheme: "http") {
            openURL(url)
        } else {
            showAlertFor(badURL: path)
        }
    }

    func showAlertFor(badURL: String) {
        alertInfo = AlertInfo(title: "Invalid URL", message: "Sorry, can't open \"\(badURL)\" because that link is invalid")
        isPresented = true
    }
}

struct ListStudentLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        ListStudentLocationsView(studentLocations: StudentInformation.sampleArray)
    }
}
