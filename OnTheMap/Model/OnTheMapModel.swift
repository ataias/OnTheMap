//
//  OnTheMapModel.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 26/01/21.
//

import Foundation
import Combine

class OnTheMapModel: ObservableObject {
    @Published var sessionToken: String? = nil
    @Published var username: String = ""
    @Published var password: String = ""

    private var cancellables: Set<AnyCancellable> = []

    func postSession() {
        OnTheMapApi.postSession(username: username, password: username)
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
