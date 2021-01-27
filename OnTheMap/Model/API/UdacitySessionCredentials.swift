//
//  UdacitySessionCredentials.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 27/01/21.
//

import Foundation

struct UdacitySessionCredentials: Codable {
    let udacity: Credentials

    init(username: String, password: String) {
        self.udacity = Credentials(username: username, password: password)
    }
}

struct Credentials: Codable {
    let username: String
    let password: String
}
