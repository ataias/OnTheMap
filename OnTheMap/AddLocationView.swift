//
//  AddLocationView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 31/01/21.
//

import SwiftUI
import CoreLocation
import MapKit

struct AddLocationView<T: ApiClient>: View {
    @State private var locationGeocode = ""
    @State private var url = ""
    /// The results of forward geolocation based on user-given geocode
    @State private var landmarks: [CLPlacemark]! = nil
    /// True when waiting for forward geocode translation after user request
    @State private var isFindingLocation = false
    // True when map to fine tune location is shown after coordinates were received
    @State private var isPickingLocation = false

    @State private var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -45, longitude: 45),
        span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))

    @EnvironmentObject var apiClient: T

    var validGeocode: Bool {
        guard let landmark = landmarks else {
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

        /// A binding that only accepts a setting to turn it off
        let isPickingLocationBinding: Binding<Bool> = Binding<Bool>(
            get: {
                return isPickingLocation
            }, set: { newValue in
                if !newValue {
                    isPickingLocation = false
                }
            })
        return VStack {
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
            NavigationLink(
                destination: PickMapLocationView(coordinateRegion: $coordinateRegion),
                isActive: isPickingLocationBinding,
                label: {
                    Button(action: {
                        findLocation()
                        isFindingLocation = true
                    }, label: {
                        Text("Find Location")
                    })
                })
            ProgressView()
                .hidden(if: !isFindingLocation)
        }
        .padding()
        .onChange(of: locationGeocode, perform: { _ in

            // FIXME when changing the location, it seems the new region is not set
            self.landmarks = nil
        })
    }

    func findLocation() {
        apiClient.find(location: locationGeocode) { (result, error) in
            DispatchQueue.main.async {
                self.isFindingLocation = false
                if let error = error {
                    print(error.localizedDescription)
                }
                self.landmarks = result
                if let landmark = self.landmarks {
                    self.isPickingLocation = true
                    self.coordinateRegion.center = landmark[0].location!.coordinate
                }
            }
        }
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView<MockApiClient>()
            .environmentObject(MockApiClient())
    }
}
