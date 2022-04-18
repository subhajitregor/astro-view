//
//  NetworkRequestError.swift
//  astro-view
//
//  Created by Subhajit on 17/04/22.
//

import Foundation

enum NetworkRequestError: Error {
    case cancelledByUser
    case waitingForConnectivity
}
