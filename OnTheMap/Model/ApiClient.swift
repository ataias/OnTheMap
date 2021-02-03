//
//  ApiClient.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 27/01/21.
//

import Foundation
import SwiftUI
import CoreLocation

protocol ApiClient: ObservableObject {
    var sessionToken: UdacitySessionToken! { get }
    var user: User! { get }
    func login(username: String, password: String, completion: @escaping () -> Void)
    func logout()
    func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy, completion: @escaping () -> Void)
    func postStudentLocation(payload: OnTheMapApi.StudentLocationPayload, completion: @escaping () -> Void)
    func find(location: String, completionHandler: @escaping CLGeocodeCompletionHandler)

}

class MockApiClient: ApiClient, ObservableObject {
    var sessionToken: UdacitySessionToken! {
        return UdacitySessionToken(account: .init(registered: true, key: "1"), session: .init(id: "sessionId", expiration: Date() + 2000))
    }

    var user: User! {
        User(nickname: "nickname", firstName: "Fulano", lastName: "de Tal")
    }

    func login(username: String, password: String, completion: () -> Void) {
        print("Logging in with username: \(username) and password: \(password)")
        completion()
    }

    func logout() {
        print("Logging out!")
    }

    func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy, completion: @escaping () -> Void) {
        print("Calling \(#function) with \(limit), \(skip), \(orderBy)")
    }

    func find(location: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        print("Calling \(#function) with location = \"\(location)\"")
    }

    func postStudentLocation(payload: OnTheMapApi.StudentLocationPayload, completion: () -> Void) {
        print("Calling \(#function) with \(payload)")
    }
}
