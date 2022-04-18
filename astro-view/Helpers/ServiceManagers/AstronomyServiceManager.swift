//
//  AstronomyServiceManager.swift
//  astro-view
//
//  Created by Subhajit on 16/04/22.
//

import Foundation

final class AstronomyServiceManager: ServiceRouter, AstronomyServiceManager.Services {
    typealias Services = DailyPictureService
}

extension AstronomyServiceManager: AstronomyLoaderLogic {
    func fetchAstronomy(completion: @escaping (Result<PicOfTheDay, Error>) -> ()) {
        self.fetchDailyPicture { result in
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
                completion(.failure(error))
            }
        }
    }
}
