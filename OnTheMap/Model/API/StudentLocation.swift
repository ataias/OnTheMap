//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import Foundation

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
}
