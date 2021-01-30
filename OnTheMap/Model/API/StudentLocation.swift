//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import Foundation
import MapKit

struct StudentLocation: Codable, Identifiable {
    let createdAt: Date
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: Date

    var id: String {
        objectId
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var fullName: String {
        firstName + " " + lastName
    }
}

struct StudentLocationResult: Codable {
    let results: [StudentLocation]
}

extension StudentLocation {
    static let sampleArray: [StudentLocation] = {
        let url = Bundle.main.url(forResource: "studentLocationsDummy", withExtension: ".json")!
        let studentLocationResult = try! FileManager.read(StudentLocationResult.self, url)
        return studentLocationResult.results
    }()

    static var sample: StudentLocation {
        sampleArray[0]
    }
}
