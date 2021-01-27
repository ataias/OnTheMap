//
//  OnTheMapApi.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 26/01/21.
//

import Foundation


enum OnTheMapApi: URLRequestRepresentable {


    static let baseURL = URL(string: "https://onthemap-api.udacity.com/v1/session")!

    case postSession(username: String, password: String)

    var urlRequest: URLRequest {
        switch self {
        case .postSession(let username, let password):
            var request = URLRequest(url: Self.baseURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONEncoder().encode(UdacitySessionCredentials(username: username, password: password))
            return request
        }
    }
}

protocol URLRequestRepresentable {
    var urlRequest: URLRequest { get }
}
