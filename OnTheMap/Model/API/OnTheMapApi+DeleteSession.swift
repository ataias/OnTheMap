//
//  OnTheMapApi+DeleteSession.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 31/01/21.
//

import Foundation
import Combine

extension OnTheMapApi {
    static func deleteSession() -> AnyPublisher<(), Error> {
        let request = OnTheMapApi.deleteSession.urlRequest
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                return OnTheMapError.urlError(error)
            })
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}

