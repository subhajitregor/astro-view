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
    private let service: AstronomyServiceLogic
    
    init(presenter: AstronomyPresentationLogic,
         router: AstronomyRoutingLogic,
         service: AstronomyServiceLogic) {
        self.presenter = presenter
        self.router = router
        self.service = service
    }
}

// MARK: - AstronomyBusinessLogic

extension AstronomyInteractor: AstronomyBusinessLogic {
    func fetchAstronomyData() {
        service.fetchAstronomy { [weak self] result in
            guard let `self` = self else { return }
            switch result {
                
            case .success(let entity):
                let response = Astronomy.Daily.Response(imageUrl: entity.imageUrl,
                                                        titleText: entity.title,
                                                        shortDescription: entity.explanation)
                self.presenter.presentData(response)
            case .failure(let error):
                self.presenter.presentError(error)
            }
        }
        
    }
}
