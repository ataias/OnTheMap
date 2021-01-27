//
//  OnTheMapApi+PostSession.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 26/01/21.
//

import Foundation
import Combine

extension OnTheMapApi {
    static func postSession(username: String, password: String) -> AnyPublisher<String, Error> {
        let request = OnTheMapApi.postSession(username: username, password: password).urlRequest
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                return OnTheMapError.urlError(error)
            })
            .map { $0.data }
            .map {
                let range = 5..<$0.count
                return $0.subdata(in: range)
            }
            .map { String(data: $0, encoding: .utf8)! }
            .eraseToAnyPublisher()
    }
}

enum OnTheMapError: Error, LocalizedError {
    case urlError(URLError)

    var errorDescription: String? {
        switch self {
        case .urlError(let urlError):
            return urlError.localizedDescription
        }
    }
}
