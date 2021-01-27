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

}

class MockApiClient: ApiClient, ObservableObject {
    func login(username: String, password: String) {
        print("Logging in with username: \(username) and password: \(password)")
    }
}
