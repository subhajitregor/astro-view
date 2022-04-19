//
//  PersistentCache.swift
//  astro-view
//
//  Created by Subhajit on 18/04/22.
//

import UIKit

protocol PersistentCacheProtocol {
    func fetchFromCache<T: Codable>(for urlRequest: URLRequest, completion: @escaping (Result<T, Error>) ->())
}

final class PersistentCache: PersistentCacheProtocol, CacheUpdateService {
    var cache: URLCache {
        let cache = URLCache.shared
        cache.diskCapacity = 1024 * 1024 * 10
        cache.memoryCapacity = 1024 * 1024 * 10
        return cache
    }
}

extension PersistentCache {
    func fetchFromCache<T: Codable>(for urlRequest: URLRequest, completion: @escaping (Result<T, Error>) ->()) {
        DispatchQueue.global(qos: .utility).async {
            
            guard let data = self.cache.cachedResponse(for: urlRequest)?.data
            else {
                print("Cache fault for image")
                completion(.failure(CacheError.fault))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if let type = T.self as? DateDecodable.Type {
                    decoder.dateDecodingStrategy = .formatted(type.dateDecodingFormat)
                }
                
                let parsedObj = try decoder.decode(T.self, from: data)
                completion(.success(parsedObj))
            } catch {
                completion(.failure(CacheError.fault))
            }
            
        }
    }
}
