//
//  NetworkRequestError.swift
//  astro-view
//
//  Created by Subhajit on 17/04/22.
//

import Foundation

enum NetworkRequestError: Error {
    case cancelledByUser
    case timeOut
    case noInternet(_ message: String)
    case notHandled
}

final class ServiceRequestError {
    class func handleError(_ error: URLError) -> NetworkRequestError {
        switch error.code {
        case .notConnectedToInternet:
            return .noInternet(error.localizedDescription)
        case .timedOut:
            return .timeOut
        default:
            return .notHandled
        }
    }
}
