//
//  OnTheMapModel.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 26/01/21.
//

import Foundation
import Combine

class OnTheMapModel: ObservableObject, ApiClient {
    @Published var sessionToken: UdacitySessionToken? = nil
//    var isAuthenticated: Bool {
//        guard let sessionToken = sessionToken else {
//            return false
//        }
//        return sessionToken.session.expiration
//    }

    private var cancellables: Set<AnyCancellable> = []

    func login(username: String, password: String) {
        guard username != "" && password != "" else {
            print("Session can't be created with empty credentials")
            return
        }
        OnTheMapApi.postSession(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .retry(3)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print("Error when running \(#function): \(error)")
                    case .finished:
                        print("Finished \(#function) successfully")
                    }
                },
                receiveValue: {
                    self.sessionToken = $0
                    print("Session token: \($0)")
                }
            )
            .store(in: &cancellables)
    }
}
