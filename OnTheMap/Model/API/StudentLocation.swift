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
    let mediaURL: String // TODO should I decode this a URL already?
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
