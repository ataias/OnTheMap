//
//  AddLocationView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 31/01/21.
//

import SwiftUI
import CoreLocation

struct AddLocationView<T: ApiClient>: View {
    @State private var locationGeocode = ""
    @State private var url = ""
    @State private var landmark: [CLPlacemark]! = nil
    @State private var isFindingLocation = false

    @EnvironmentObject var apiClient: T

    var validGeocode: Bool {
        guard let landmark = landmark else {
            return false
        }
        return locationGeocode.count > 0 && landmark.count > 0
    }

    var validURL: Bool {
        if let _ = URL(from: url, withDefaultScheme: "http") {
            return true
        }
        return false
    }

    var body: some View {
        VStack {
            Image("earth-globe")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.bottom)
            TextField("The location name", text: $locationGeocode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .border(validGeocode ? Color(UIColor.separator) : Color.red)
            TextField("The URL", text: $url)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .textContentType(.URL)
                .border(validURL ? Color(UIColor.separator) : Color.red)
            // TODO add validation to URL and make border red if invalid
            Button(action: {
                findLocation()
                isFindingLocation = true
            }, label: {
                Text("Find Location")
            })
            ProgressView()
                .hidden(if: !isFindingLocation)
        }
        .padding()
    }

    func findLocation() {
        apiClient.find(location: locationGeocode) { (result, error) in
            self.isFindingLocation = false
            if let error = error {
                print(error.localizedDescription)
            }
            self.landmark = result
            print(self.landmark)
        }
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView<MockApiClient>()
            .environmentObject(MockApiClient())
    }
}
