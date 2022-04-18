//
//  PicOfTheDay.swift
//  astro-view
//
//  Created by Subhajit on 17/04/22.
//

import Foundation

struct PicOfTheDay: Codable {
    let date: Date?
    let title: String?
    let explanation: String?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case date, title, explanation
        case imageUrl = "hdurl"
    }
}

extension PicOfTheDay {
    static let dateDecodingFormat: DateFormatter = {
        DateFormatter.yyyyMMdd_hyphenated
    }()
}
