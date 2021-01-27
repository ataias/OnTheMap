//
//  UdacityError.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 27/01/21.
//

import Foundation

struct UdacityError: Codable {
    let status: Int
    let error: String
}

extension UdacityError: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
