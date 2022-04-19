//
//  CacheService.swift
//  astro-view
//
//  Created by Subhajit on 19/04/22.
//

import Foundation

protocol CacheUpdateService: AnyObject {
    func saveInCache(data: Data?, response: URLResponse?, for request: URLRequest)
}

extension CacheUpdateService where Self: PersistentCache {
    func saveInCache(data: Data?, response: URLResponse?, for request: URLRequest) {
        guard let data = data,
              let response = response
        else {
            return
        }
        let cacheToSave = CachedURLResponse(response: response, data: data)
        self.cache.storeCachedResponse(cacheToSave, for: request)
    }
}
