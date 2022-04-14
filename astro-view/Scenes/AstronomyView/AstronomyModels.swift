//
//  AstronomyModels.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import Foundation

enum Astronomy {
    enum Daily {
        struct Request {}
        struct Response {}
        struct ViewModel: AstronomyTableCellData {
            var imageUrl: String?
            var titleText: AttributedString?
            var shortDescription: AttributedString?
        }
    }
}
