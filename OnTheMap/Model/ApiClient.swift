//
//  ApiClient.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 27/01/21.
//

import Foundation
import SwiftUI

protocol ApiClient: ObservableObject {
    func login(username: String, password: String)
    func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy)

}

class MockApiClient: ApiClient, ObservableObject {
    func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy) {
        print("Calling \(#function) with \(limit), \(skip), \(orderBy)")
    }

    func login(username: String, password: String) {
        print("Logging in with username: \(username) and password: \(password)")
    }
}
