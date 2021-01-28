//
//  OnTheMapApi+PostSession.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 26/01/21.
//

import Foundation
import Combine

extension OnTheMapApi {
    static func postSession(username: String, password: String) -> AnyPublisher<UdacitySessionToken, Error> {
        let request = OnTheMapApi.postSession(username: username, password: password).urlRequest
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                return OnTheMapError.urlError(error)
            })
            .map { $0.data }
            .map { (data: Data) -> Data in
                let range = 5..<data.count
                return data.subdata(in: range)
            }
            .tryMap({ data throws -> UdacitySessionToken in
                let decoder = UdacitySessionToken.decoder

                guard let sessionToken = try? decoder.decode(UdacitySessionToken.self, from: data) else {
                    let error = try decoder.decode(UdacityError.self, from: data)
                    throw OnTheMapError.udacityApiError(error)
                }
                return sessionToken
            })
            .eraseToAnyPublisher()
    }
}

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
