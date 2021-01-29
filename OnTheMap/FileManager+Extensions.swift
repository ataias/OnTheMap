//
//  FileManager+Extensions.swift
//  OnTheMap
//
//  Created by Ataias Pereira Reis on 29/01/21.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }

    /// Decodes from file URL using the default JSONDecoder
    /// - Parameter url: the url to read the data from
    /// - Returns: an optional with the decoded data
    static func read<T: Decodable>(_ type: T.Type, _ url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        let decoder = UdacitySessionToken.decoder
        return try decoder.decode(type, from: data)
    }

    /// Saves a codable structure to the given URL using the default JSONEncoder
    /// - Parameter encodable: the encodable data you want to have
    /// - Parameter to: the url to save the file to
    /// - throws
    static func save<T: Encodable>(_ encodable: T, to url: URL) throws {
        let encoder = UdacitySessionToken.encoder
        let data = try encoder.encode(encodable)
        try data.write(to: url, options: [.atomicWrite])
    }
}
