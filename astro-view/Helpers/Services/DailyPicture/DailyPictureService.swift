//
//  DailyPictureService.swift
//  astro-view
//
//  Created by Subhajit on 16/04/22.
//

import Foundation

protocol DailyPictureService {
    var dailyPictureEndpoint: EndPointType { get }
    func fetchDailyPicture(completion: @escaping (Result<Data?, Error>) -> ())
}

extension DailyPictureService where Self: ServiceRouterProtocol {
    
    func fetchDailyPicture(completion: @escaping (Result<Data?, Error>) -> ()) {
        request(self.dailyPictureEndpoint) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
