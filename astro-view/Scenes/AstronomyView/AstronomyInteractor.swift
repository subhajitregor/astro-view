//
//  AstronomyInteractor.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import Foundation

protocol AstronomyBusinessLogic {
    func fetchAstronomyData()
}

protocol AstronomyRoutingLogic {}

final class AstronomyInteractor {
    private let presenter: AstronomyPresentationLogic
    private let router: AstronomyRoutingLogic
    
    init(presenter: AstronomyPresentationLogic,
         router: AstronomyRoutingLogic) {
        self.presenter = presenter
        self.router = router
    }
}

// MARK: - AstronomyBusinessLogic

extension AstronomyInteractor: AstronomyBusinessLogic {
    func fetchAstronomyData() {}
}
