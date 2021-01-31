//
//  PickMapLocationView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 31/01/21.
//

import MapKit
import SwiftUI

struct PickMapLocationView: View {
    @Binding var coordinateRegion: MKCoordinateRegion
    @Binding var studentLocation: StudentLocation
    
    var body: some View {
        Map(coordinateRegion: $coordinateRegion,
            annotationItems: [studentLocation],
            annotationContent: mapAnnotation(location:)
        )
    }

    func mapAnnotation(location: StudentLocation) -> MapPin {
        MapPin(coordinate: location.coordinate)
    }
}

struct PickMapLocationView_Previews: PreviewProvider {
    static let coordinateRegion = MKCoordinateRegion(
        center: StudentLocation.sample.coordinate,
        span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15))

    static var previews: some View {
        PickMapLocationView(
            coordinateRegion: .constant(coordinateRegion),
            studentLocation: .constant(StudentLocation.sample)
        )
    }
}
