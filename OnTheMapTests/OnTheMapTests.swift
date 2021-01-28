//
//  OnTheMapTests.swift
//  OnTheMapTests
//
//  Created by Ataias Pereira Reis on 28/01/21.
//

import XCTest
@testable import OnTheMap

class OnTheMapTests: XCTestCase {
    func testDecoder() throws {
        let sut = UdacitySessionToken.decoder

        let data = """
            {
                "account":{
                    "registered":true,
                    "key":"3903878747"
                },
                "session":{
                    "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
                    "expiration":"2015-05-10T16:48:30.760460Z"
                }
            }
        """.data(using: .utf8)!

        let decoded = try sut.decode(UdacitySessionToken.self, from: data)
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar,
                                            year: 2015,
                                            month: 05,
                                            day: 10,
                                            hour: 16,
                                            minute: 48,
                                            second: 30,
                                            nanosecond: 760_000_000) // Notice this misses some precision; we are accepting that here
        dateComponents.timeZone = TimeZone(secondsFromGMT: 0)

        // DateComponents as a date specifier
        let date = calendar.date(from: dateComponents)!
        XCTAssertEqual(date, decoded.session.expiration)
    }

}
