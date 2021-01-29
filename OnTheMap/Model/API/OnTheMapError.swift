//
//  OnTheMapError.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import Foundation

enum OnTheMapError: Error, LocalizedError {
    case urlError(URLError)
    case udacityApiError(UdacityError)

    var errorDescription: String? {
        switch self {
        case .urlError(let urlError):
            return urlError.localizedDescription
        case .udacityApiError(let udacityError):
            return udacityError.localizedDescription
        }
    }

}
