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
    var body: some View {

        HStack {
            VStack(alignment: .trailing) {
                Text("Name").bold()
                Text("Latitude").bold()
                Text("Longitude").bold()
            }
            VStack(alignment: .leading) {
                Text(studentLocation.fullName)
                Text("\(studentLocation.latitude)")
                Text("\(studentLocation.longitude)")
            }
        }
        .padding()
    }
}

struct StudentLocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudentLocationDetailView(studentLocation: StudentLocation.sample)
    }
}
