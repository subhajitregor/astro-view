//
//  NetworkResponseError.swift
//  astro-view
//
//  Created by Subhajit on 14/04/22.
//

import Foundation

enum NetworkResponseError: Error {

    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    
    case Custom(message:String)
    
    var errorMessage: String {
        switch self {
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Bad request"
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."

        case .Custom(let message):
            return message
        }
    }
}

// MARK: NetworkResponseError Builder

final class ServiceResponse {
    class func handleNetworkResponse(_ response: URLResponse?) -> Result<Int,Error> {
        guard let response = response as? HTTPURLResponse else {
            return .failure(NetworkResponseError.Custom(message: "Response is not of Type: HTTPURLResponse"))
        }

        switch response.statusCode {
        case 200...299: return .success(response.statusCode)
        case 401...500: return .failure(NetworkResponseError.authenticationError)
        case 501...599: return .failure(NetworkResponseError.badRequest)
        case 600: return .failure(NetworkResponseError.outdated)
        default: return .failure(NetworkResponseError.failed)
        }
    }
}

