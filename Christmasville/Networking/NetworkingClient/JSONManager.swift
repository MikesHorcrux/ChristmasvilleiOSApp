//
//  JSONManager.swift
//  JuC
//
//  Created by Mike on 4/2/23.
//

import Foundation

struct JSON {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        //encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
