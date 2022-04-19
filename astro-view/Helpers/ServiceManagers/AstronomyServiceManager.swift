//
//  AstronomyServiceManager.swift
//  astro-view
//
//  Created by Subhajit on 16/04/22.
//

import Foundation

final class AstronomyServiceManager: ServiceRouter<PersistentCache>, AstronomyServiceManager.Services {
    
    typealias Services = DailyPictureService
    
    var dailyPictureEndpoint: EndPointType = DailyPictureEndpoint()
    
}

extension AstronomyServiceManager: AstronomyServiceLogic {
    func fetchAstronomy(completion: @escaping (Result<PicOfTheDay, Error>) -> ()) {
        self.fetchDailyPicture { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(NetworkResponseError.noData))
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(PicOfTheDay.dateDecodingFormat)
                do {
                    let entity = try decoder.decode(PicOfTheDay.self, from: data)
                    completion(.success(entity))
                } catch {
                    completion(.failure(NetworkResponseError.Custom(message: error.localizedDescription)))
                }
            case .failure(let error):
                self.serviceStore?.fetchFromCache(for: self.dailyPictureEndpoint.urlRequest)
                { (result: Result<PicOfTheDay, Error>) in
                    switch result {
                    case .success(let success):
                        completion(.success(success))
                        completion(.failure(error))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
            }
        }
    }
}
