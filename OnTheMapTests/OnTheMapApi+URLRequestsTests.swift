//
//  OnTheMapApi+URLRequests.swift
//  OnTheMapTests
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import XCTest
@testable import OnTheMap

class OnTheMapApi_URLRequestsTests: XCTestCase {

    func test_getStudentLocations_with_limit200_skip100_orderByCreatedAtAscending() throws {
        let sut: OnTheMapApi = OnTheMapApi.getStudentLocations(limit: 200, skip: 100, orderBy: .ascending(.createdAt))
        let urlString = sut.urlRequest.url!.absoluteString
        XCTAssertEqual("https://onthemap-api.udacity.com/v1/StudentLocation?limit=200&skip=100&order=createdAt", urlString)
    }


}
