//
//  DateFormatter+Extensions.swift
//  astro-view
//
//  Created by Subhajit on 18/04/22.
//

import Foundation

extension DateFormatter {
    static let yyyyMMdd_hyphenated: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
