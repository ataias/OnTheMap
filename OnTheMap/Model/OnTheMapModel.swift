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
    @Published var studentLocations: [StudentLocation] = []

    var authenticated: Bool {
        guard let sessionToken = sessionToken else {
            return false
        }
        return sessionToken.session.expiration > Date()
    }

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

    func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy) {
        OnTheMapApi.getStudentLocations(limit: limit, skip: skip, orderBy: orderBy)
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
                    self.studentLocations = $0.results
                }
            )
            .store(in: &cancellables)

    }
}
