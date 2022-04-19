//
//  CacheError.swift
//  astro-view
//
//  Created by Subhajit on 19/04/22.
//

import Foundation

enum CacheError: Error {
    case fault
    case decodingFailed
    case encodingFailed
    
    var errorMessage: String {
        switch self {
            
        case .fault:
            return "Fault occured in cache"
        case .decodingFailed:
            return "decoding failed"
        case .encodingFailed:
            return "encoding failed"
        }
    }
}
