//
//  UdacitySessionToken.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 27/01/21.
//

import Foundation

struct UdacitySessionToken: Codable {

    let account: Account
    let session: Session

    struct Account: Codable {
        let registered: Bool
        let key: String
    }

    struct Session: Codable {
        let id: String
        let expiration: Date
    }

    /// Source: [Vini App at StackOverflow](https://stackoverflow.com/a/46538676/2304697)
    static let decoder: JSONDecoder = {
        enum DateError: String, Error {
            case invalidDate
        }

        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            throw DateError.invalidDate
        })
        
        return decoder
    }()

}
