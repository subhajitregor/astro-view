//
//  AstronomyViewController.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import UIKit

protocol AstronomyDisplayLogic: AnyObject {
    func displaySuccess(_ viewModel: [Astronomy.Daily.ViewModel])
    func displayError(_ error: Error)
}

final class AstronomyViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var noInternetView: NoInternetView!
    
    private var interactor: AstronomyBusinessLogic?
    private var viewModels: [Astronomy.Daily.ViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Method Injection
    func setInteractor(_ interactor: AstronomyBusinessLogic) {
        self.interactor = interactor
    }
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        fetchData()
    }
}

// MARK: - Private Methods

private extension AstronomyViewController {
    func registerCells() {
        tableView.register(AstronomyTableCell.self)
    }
    
    func fetchData() {
        interactor?.fetchAstronomyData()
    }
    
    func showErrorView(_ show: Bool) {
        noInternetView.isHidden = !show
    }
}

// MARK: - AstronomyDisplayLogic

extension AstronomyViewController: AstronomyDisplayLogic {
    func displaySuccess(_ viewModel: [Astronomy.Daily.ViewModel]) {
        DispatchQueue.main.async {
            self.showErrorView(false)
            self.viewModels = viewModel
        }
    }
    
    func displayError(_ error: Error) {
        if let error = error as? NetworkRequestError {
            switch error {
            case .noInternet, .timeOut:
                DispatchQueue.main.async {
                    self.showErrorView(true)
                }
            case .notHandled, .cancelledByUser:
                break
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension AstronomyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AstronomyTableCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setCellData(viewModels[indexPath.row])
        return cell
    }
}
