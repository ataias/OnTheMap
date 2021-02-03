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
    let completion: () -> Void
    
    var body: some View {
        Map(coordinateRegion: $coordinateRegion)
            .overlay(pin)
            .overlay(
                StyledButton(text: "Finish", action: completion)
                    .padding([.trailing, .leading]),
                alignment: .bottom)
    }

    @ViewBuilder
    var pin: some View {
        Image(systemName: "mappin")
            .font(.title)
            .foregroundColor(.red)
    }
}

struct PickMapLocationView_Previews: PreviewProvider {
    static let coordinateRegion = MKCoordinateRegion(
        center: StudentLocation.sample.coordinate,
        span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15))

    static var previews: some View {
        PickMapLocationView(coordinateRegion: .constant(coordinateRegion), completion: {})
    }
}
