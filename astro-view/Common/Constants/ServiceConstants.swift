//
//  ServiceConstants.swift
//  astro-view
//
//  Created by Subhajit on 15/04/22.
//

import Foundation

var serviceEnvironment = ServiceConstants.Staging.self

protocol ServiceEnvironment {
    static var baseUrl: String { get }
    static var apiKeyValuePair: [String: String] { get }
}

enum ServiceConstants {
    struct Staging: ServiceEnvironment {
        private init() {}
        static var baseUrl: String = "https://api.nasa.gov"
        /*
         NASA API
         Account Email: subhajit.regor@gmail.com
         Account ID: 6c21d97b-35ec-4edb-9f8d-76e57f4c02c8
         */
        static var apiKeyValuePair: [String: String] = ["api_key": "oQAgkZftC3V6WivQ8K9S00feaDbh1IRWBKRdYkdP"]
    }
}
