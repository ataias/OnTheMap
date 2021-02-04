//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import Foundation
import MapKit

struct StudentInformation: Codable, Identifiable {
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

    var formattedCreatedAt: String {
        Self.dateFormatter.string(from: createdAt)
    }
    var formattedUpdatedAt: String {
        Self.dateFormatter.string(from: updatedAt)
    }
}

struct GetStudentLocationsResult: Codable {
    let results: [StudentInformation]
}

struct PostStudentLocationResult: Codable {
    let objectId: String
    let createdAt: Date
}

extension StudentInformation {
    static let sampleArray: [StudentInformation] = {
        let url = Bundle.main.url(forResource: "studentLocationsDummy", withExtension: ".json")!
        let studentLocationResult = try! FileManager.read(GetStudentLocationsResult.self, url)
        return studentLocationResult.results
    }()

    static var sample: StudentInformation {
        sampleArray[0]
    }
}

extension StudentInformation {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

}
