//
//  AstronomyPresenter.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import Foundation

protocol AstronomyPresentationLogic {
    func presentData(_ response: Astronomy.Daily.Response)
    func presentError()
}

final class AstronomyPresenter {
    private weak var viewController: AstronomyDisplayLogic?
    
    init(displayLogic: AstronomyDisplayLogic) {
        self.viewController = displayLogic
    }
}

// MARK: - AstronomyPresentationLogic

extension AstronomyPresenter: AstronomyPresentationLogic {
    func presentData(_ response: Astronomy.Daily.Response) {
        let viewModels = createViewModelToDisplay(models: response)
        viewController?.displaySuccess(viewModels)
    }
    
    func presentError() {}
}

// MARK: - Private

extension AstronomyPresenter {
    func createViewModelToDisplay(models: Astronomy.Daily.Response) -> [Astronomy.Daily.ViewModel] {
        [Astronomy.Daily.ViewModel()]
    }
}
