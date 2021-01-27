//
//  UdacitySessionToken.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 27/01/21.
//

import Foundation

struct UdacitySessionToken: Codable {

    let account: Account
    let session: Session

    struct Account: Codable {
        let registered: Bool
        let key: String
    }

    struct Session: Codable {
        let id: String
        let expiration: Date
    }

}
