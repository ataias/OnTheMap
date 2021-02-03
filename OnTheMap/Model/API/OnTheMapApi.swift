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
    case deleteSession
    case getStudent(id: String)
    case getStudentLocations(limit: Int, skip: Int, orderBy: OrderBy)
    case postStudentLocation(StudentLocationPayload)

    var urlRequest: URLRequest {
        switch self {
        case .postSession(let username, let password):
            var request = URLRequest(url: Self.baseURL.appendingPathComponent("session"))
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONEncoder().encode(UdacitySessionCredentials(username: username, password: password))
            return request
        case .deleteSession:
            var request = URLRequest(url: Self.baseURL.appendingPathComponent("session"))
            request.httpMethod = "DELETE"
            if let xsrfCookie = HTTPCookieStorage.shared.cookies!.first(where: { $0.name == "XSRF-TOKEN" }) {
                request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            }
            return request
        case .getStudent(id: let id):
            let url = Self.baseURL.appendingPathComponent("users").appendingPathComponent(id)
            return URLRequest(url: url)
        case .getStudentLocations(limit: let limit, skip: let skip, orderBy: let orderBy):
            var components = URLComponents(url: Self.baseURL.appendingPathComponent("StudentLocation"), resolvingAgainstBaseURL: true)!
            components.queryItems = [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "skip", value: "\(skip)"),
                URLQueryItem(name: "order", value: "\(orderBy)")
            ]
            return URLRequest(url: components.url!)
        case .postStudentLocation(let payload):
            var request = URLRequest(url: Self.baseURL.appendingPathComponent("StudentLocation"))
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONEncoder().encode(payload)
            return request
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

    struct StudentLocationPayload: Codable {
        let uniqueKey: String
        let firstName: String
        let lastName: String
        let mapString: String
        let mediaURL: URL
        let latitude: Double
        let longitude: Double
    }
}



protocol URLRequestRepresentable {
    var urlRequest: URLRequest { get }
}
