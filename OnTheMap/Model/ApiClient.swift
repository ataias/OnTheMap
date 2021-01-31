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
    func login(username: String, password: String, completion: @escaping () -> Void)
    func logout()
    func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy)
    func find(location: String, completionHandler: @escaping CLGeocodeCompletionHandler)

}

class MockApiClient: ApiClient, ObservableObject {

    func login(username: String, password: String, completion: () -> Void) {
        print("Logging in with username: \(username) and password: \(password)")
        completion()
    }

    func logout() {
        print("Logging out!")
    }
    func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy) {
        print("Calling \(#function) with \(limit), \(skip), \(orderBy)")
    }

    func find(location: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        print("Calling \(#function) with location = \"\(location)\"")
    }
    
}
