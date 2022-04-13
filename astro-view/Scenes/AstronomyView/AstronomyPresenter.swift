//
//  AstronomyPresenter.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import Foundation

protocol AstronomyPresentationLogic {
    func presentData()
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
    func presentData() {}
    func presentError() {}
}
