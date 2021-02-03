//
//  OnTheMapApi+StudentData.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 03/02/21.
//

import Foundation
import Combine

extension OnTheMapApi {
    static func getStudentData(id: String) -> AnyPublisher<User, Error> {
        let request = OnTheMapApi.getStudent(id: id).urlRequest
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                return OnTheMapError.urlError(error)
            })
            .map { $0.data }
            .map { (data: Data) -> Data in
                let range = 5..<data.count
                return data.subdata(in: range)
            }
            .tryMap({ data throws -> User in
                let decoder = UdacitySessionToken.decoder
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                guard let userResponse = try? decoder.decode(UserResponse.self, from: data) else {
                    let error = try decoder.decode(UdacityError.self, from: data)
                    throw OnTheMapError.udacityApiError(error)
                }
                return userResponse.user
            })
            .eraseToAnyPublisher()
    }
}
