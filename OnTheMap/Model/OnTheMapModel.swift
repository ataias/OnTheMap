//
//  OnTheMapModel.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 26/01/21.
//

import Foundation
import Combine
import CoreLocation

class OnTheMapModel: ObservableObject, ApiClient {
    @Published var sessionToken: UdacitySessionToken! = nil
    @Published var studentLocations: [StudentLocation] = []
    @Published var user: User! = nil
    var findLocationCache: [String: [CLPlacemark]] = [:]

    static let sessionTokenURL = FileManager.documentsDirectory.appendingPathComponent("sessionToken.json")
    public init() {
        if FileManager.default.fileExists(atPath: Self.sessionTokenURL.path) {
            self.sessionToken = try! FileManager.read(UdacitySessionToken.self, Self.sessionTokenURL)
        }
        getStudentData()
    }

    var authenticated: Bool {
        guard let sessionToken = sessionToken else {
            return false
        }
        return sessionToken.session.expiration > Date()
    }

    private var cancellables: Set<AnyCancellable> = []

    func login(username: String, password: String, completion: @escaping (Result<(), Error>) -> Void) {
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
                        completion(Result.failure(error))
                        print("Error when running \(#function): \(error)")
                    case .finished:
                        completion(Result.success(()))
                        print("Finished \(#function) successfully")
                    }

                },
                receiveValue: {
                    self.sessionToken = $0
                    try! FileManager.save(self.sessionToken, to: Self.sessionTokenURL)
                }
            )
            .store(in: &cancellables)
    }

    func logout() {
        OnTheMapApi.deleteSession()
            .receive(on: DispatchQueue.main)
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
                    try? FileManager.default.removeItem(at: Self.sessionTokenURL)
                    self.sessionToken = nil
                }
            )
            .store(in: &cancellables)
    }

    func getStudentData() {
        $sessionToken
            .compactMap { sessionToken -> String? in
                sessionToken?.account.key
            }
            .flatMap {
                OnTheMapApi.getStudentData(id: $0)
            }
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
                    self.user = $0
                }
            )
            .store(in: &cancellables)
    }

    func getStudentLocations(limit: Int, skip: Int, orderBy: OnTheMapApi.OrderBy, completion: @escaping () -> Void) {
        OnTheMapApi.getStudentLocations(limit: limit, skip: skip, orderBy: orderBy)
            .receive(on: DispatchQueue.main)
            .retry(3)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print("Error when running \(#function): \(error)")
                    case .finished:
                        completion()
                        print("Finished \(#function) successfully")
                    }
                },
                receiveValue: {
                    self.studentLocations = $0.results
                }
            )
            .store(in: &cancellables)
    }

    func postStudentLocation(payload: OnTheMapApi.StudentLocationPayload, completion: @escaping () -> Void) {
        OnTheMapApi.postStudentLocation(payload: payload)
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
                receiveValue: { _ in
                    completion()
                }
            )
            .store(in: &cancellables)
    }


    func find(location: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        if let landmark = findLocationCache[location] {
            completionHandler(landmark, nil)
            return
        }

        CLGeocoder().geocodeAddressString(location) { (result, error) in
            if let landmark = result {
                self.findLocationCache[location] = landmark
            }
            completionHandler(result, error)
        }
    }
}
