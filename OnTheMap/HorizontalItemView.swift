//
//  HorizontalItemView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 30/01/21.
//

import SwiftUI

struct HorizontalItemView: View {
    let title: String
    let value: String
    let isUrl: Bool

    // MARK: - State, Environment and computed properties
    @State private var isPresented = false
    @State private var alertMessage = ""
    @Environment(\.openURL) var openURL

    init(title: String, value: CustomStringConvertible, isUrl: Bool = false) {
        self.title = title
        self.value = value.description
        self.isUrl = isUrl
    }

    var body: some View {
        Group {
            HStack {
                Text(title).bold()
                Spacer()
            }
            HStack {
                valueView
                Spacer()
            }
            .alert(isPresented: $isPresented, content: {
                Alert(title: Text("Invalid URL"), message: Text(alertMessage), dismissButton: Alert.Button.default(Text("OK")))
            })
        }
    }

    @ViewBuilder
    var valueView: some View {
        if isUrl {
            Button(action: { openURL(path: value) }, label: {
                Text(value)
            })
        } else {
            Text(value)
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
        alertMessage = "Sorry, can't open \"\(badURL)\" because that link is invalid"
        isPresented = true
    }
}

struct HorizontalItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            HorizontalItemView(title: "Title", value: "Value")
        }
        .padding()
    }
}
