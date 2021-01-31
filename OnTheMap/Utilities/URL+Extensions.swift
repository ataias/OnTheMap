//
//  URL+Extensions.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 30/01/21.
//

import Foundation

extension URL {
    /// True if the URL is well formed, false otherwise
    ///
    /// Source: [Stackoverflow](https://stackoverflow.com/a/37065820/2304697)
    var valid: Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self.absoluteString)
    }

    init?(from path: String, withDefaultScheme scheme: String) {
        guard var urlComponents = URLComponents(string: path) else {
            return nil
        }

        if urlComponents.scheme == nil {
            urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = path
        }
        let url = urlComponents.url!

        guard url.valid else {
            return nil
        }

        self = url
    }
}

