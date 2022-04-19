//
//  AstronomyModule.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import UIKit

struct AstronomyModuleDependencies {
    let router: AstronomyRoutingLogic
}

final class AstronomyModule {
    private var externalDependencies: AstronomyModuleDependencies
    
    init(dependencies: AstronomyModuleDependencies) {
        externalDependencies = dependencies
    }
}

extension AstronomyViewController: StoryboardIdentifiable {}

extension AstronomyModule: SceneBuilder {
    func build() -> AstronomyViewController {
        let viewController: AstronomyViewController = UIStoryboard.storyboard(.astronomy).createViewController()
        
        let presenter = AstronomyPresenter(displayLogic: viewController)
        let astronomyServiceManager = AstronomyServiceManager()
        let service: AstronomyServiceLogic = astronomyServiceManager
        astronomyServiceManager.serviceStore = PersistentCache()
        let interactor = AstronomyInteractor(presenter: presenter, router: externalDependencies.router, service: service)
        
        viewController.setInteractor(interactor)
        
        return viewController
    }
}


