//
//  DailyPictureService.swift
//  astro-view
//
//  Created by Subhajit on 16/04/22.
//

import Foundation

protocol DailyPictureService {
    func fetchDailyPicture(completion: @escaping (Result<Data?, Error>) -> ())
}

extension DailyPictureService where Self: ServiceRouterProtocol {
    private var endpoint: DailyPictureEndpoint {
        DailyPictureEndpoint()
    }
    
    func fetchDailyPicture(completion: @escaping (Result<Data?, Error>) -> ()) {
        request(self.endpoint) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
