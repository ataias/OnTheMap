//
//  StudentLocationDetailView.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 30/01/21.
//

import SwiftUI

extension HorizontalAlignment {
    private enum CustomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[HorizontalAlignment.leading]
        }
    }

    static let customAlignment = HorizontalAlignment(CustomAlignment.self)
}

struct StudentLocationDetailView: View {
    let studentLocation: StudentLocation

    var columns: [GridItem] = [
        .init(.fixed(150)),
        .init(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            HorizontalItemView(title: "Name", value: studentLocation.fullName)
            HorizontalItemView(title: "URL", value: studentLocation.mediaURL, isUrl: true)
            HorizontalItemView(title: "Latitude", value: studentLocation.latitude)
            HorizontalItemView(title: "Longitude", value: studentLocation.longitude)
            HorizontalItemView(title: "Location", value: studentLocation.mapString)
            HorizontalItemView(title: "Created At", value: studentLocation.formattedCreatedAt)
            HorizontalItemView(title: "Updated At", value: studentLocation.formattedUpdatedAt)
            
        }
        .font(.body)
        .padding()
    }
}

struct StudentLocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudentLocationDetailView(studentLocation: StudentLocation.sample)
    }
}
