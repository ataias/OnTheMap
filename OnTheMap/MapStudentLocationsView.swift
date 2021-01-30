//
//  MapStudentLocationsView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 30/01/21.
//

import SwiftUI
import MapKit

struct MapStudentLocationsView: View {
    let studentLocations: [StudentLocation]

    @State private var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 56.948889, longitude: 24.106389),
        span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15))
    @State private var presentedStudentLocation: StudentLocation? = nil

    var body: some View {
        Map(coordinateRegion: $coordinateRegion,
            annotationItems: studentLocations,
            annotationContent: mapAnnotation(location:)
        ).edgesIgnoringSafeArea(.all)
        .sheet(item: $presentedStudentLocation) { location in
            StudentLocationDetailView(studentLocation: location)
        }
    }

    func mapAnnotation(location: StudentLocation) -> MapAnnotation<OnTheMapPinView> {
        MapAnnotation(coordinate: location.coordinate) {
            OnTheMapPinView(action: {
                presentedStudentLocation = location
            })
        }
    }
}

struct MapStudentLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        MapStudentLocationsView(studentLocations: StudentLocation.sampleArray)
    }
}
