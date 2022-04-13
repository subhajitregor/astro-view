//
//  AstronomyViewController.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import UIKit

protocol AstronomyDisplayLogic: AnyObject {
    func displaySuccess()
    func displayError()
}

final class AstronomyViewController: UIViewController {
    private var interactor: AstronomyBusinessLogic?
    
    // MARK: Method Injection
    func setInteractor(_ interactor: AstronomyBusinessLogic) {
        self.interactor = interactor
    }
}

// MARK: - AstronomyDisplayLogic

extension AstronomyViewController: AstronomyDisplayLogic {
    func displaySuccess() {}
    func displayError() {}
}
