//
//  Student.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 03/02/21.
//

import Foundation

struct UserResponse: Codable {
    let user: User
}

struct User: Codable {
    let nickname: String
    // Udacity's API doesn't return the first and last name always; it is bizarre...
    let firstName: String?
    let lastName: String?
}
