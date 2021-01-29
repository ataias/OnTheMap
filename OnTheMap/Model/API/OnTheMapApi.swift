//
//  OnTheMapApi.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 26/01/21.
//

import Foundation


enum OnTheMapApi: URLRequestRepresentable {


    static let baseURL = URL(string: "https://onthemap-api.udacity.com/v1/")!

    case postSession(username: String, password: String)
    case getStudentLocations(limit: Int, skip: Int, orderBy: OrderBy)

    var urlRequest: URLRequest {
        switch self {
        case .postSession(let username, let password):
            var request = URLRequest(url: Self.baseURL.appendingPathComponent("session"))
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONEncoder().encode(UdacitySessionCredentials(username: username, password: password))
            return request
        case .getStudentLocations(limit: let limit, skip: let skip, orderBy: let orderBy):
            var components = URLComponents(url: Self.baseURL.appendingPathComponent("StudentLocation"), resolvingAgainstBaseURL: true)!
            components.queryItems = [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "skip", value: "\(skip)"),
                URLQueryItem(name: "order", value: "\(orderBy)")
            ]
            return URLRequest(url: components.url!)
        }
    }

    enum OrderBy: CustomStringConvertible {
        case ascending(Key)
        case descending(Key)

        enum Key: String {
            case createdAt
            case firstName
            case lastName
            case latitude
            case longitude
            case mapString
            case mediaURL
            case objectId
            case uniqueKey
            case updatedAt
        }

        var description: String {
            switch self {
            case .ascending(let key):
                return "\(key.rawValue)"
            case .descending(let key):
                return "-\(key.rawValue)"
            }
        }

    }
}



protocol URLRequestRepresentable {
    var urlRequest: URLRequest { get }
}
