//
//  OnTheMapApi+StudentLocation.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import Foundation
import Combine

extension OnTheMapApi {
    static func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy) -> AnyPublisher<GetStudentLocationsResult, Error> {
        let request = OnTheMapApi.getStudentLocations(limit: limit, skip: skip, orderBy: orderBy).urlRequest
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                return OnTheMapError.urlError(error)
            })
            .map { $0.data }
            .tryMap({ data throws -> GetStudentLocationsResult in
                let decoder = UdacitySessionToken.decoder

                guard let studentLocation = try? decoder.decode(GetStudentLocationsResult.self, from: data) else {
                    let error = try decoder.decode(UdacityError.self, from: data)
                    throw OnTheMapError.udacityApiError(error)
                }
                return studentLocation
            })
            .eraseToAnyPublisher()
    }

    static func postStudentLocation(payload: StudentLocationPayload) -> AnyPublisher<PostStudentLocationResult, Error> {
        let request = OnTheMapApi.postStudentLocation(payload).urlRequest
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                return OnTheMapError.urlError(error)
            })
            .map { $0.data }
            .tryMap({ data throws -> PostStudentLocationResult in
                let decoder = UdacitySessionToken.decoder

                guard let response = try? decoder.decode(PostStudentLocationResult.self, from: data) else {
                    let error = try decoder.decode(UdacityError.self, from: data)
                    throw OnTheMapError.udacityApiError(error)
                }
                return response
            })
            .eraseToAnyPublisher()
    }
}
