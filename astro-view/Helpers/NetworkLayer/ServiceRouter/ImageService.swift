//
//  ImageService.swift
//  astro-view
//
//  Created by Subhajit on 18/04/22.
//

import UIKit

protocol ImageServiceProtocol {
    func loadImage(_ urlString: String?, defaultImage: UIImage?)
}

extension ImageServiceProtocol where Self: UIImageView {
    private var cache: URLCache {
        let cache = URLCache.shared
        cache.diskCapacity = 1024 * 1024 * 10
        cache.memoryCapacity = 1024 * 1024 * 10
        return cache
    }
    
    func loadImage(_ urlString: String?, defaultImage: UIImage? = nil) {
        guard let urlString = urlString,
              let url = URL(string: urlString)
        else {
            print("Invalid URL.")
            self.image = defaultImage
            return
        }
        
        let request = URLRequest(url: url)
        
        retriveImageFromCache(request) { [weak self] image in
            guard let `self` = self else { return }
            if let image = image {
                self.image = image
            } else {
                self.downloadImage(from: request) { image in
                    if let image = image {
                        self.image = image
                    } else {
                        self.image = defaultImage
                    }
                }
            }
        }
        
        
    }
    
    private func downloadImage(from request: URLRequest, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, _ in
                guard let `self` = self else { return }
                guard let data = data else {
                    print("Invalid Image Data recieved.")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                self.saveImageInCache(data: data, response: response, for: request)
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }
            dataTask.resume()
        }
    }
    
    private func retriveImageFromCache(_ request: URLRequest, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let `self` = self else { return }
            guard let data = self.cache.cachedResponse(for: request)?.data,
                  let image = UIImage(data: data)
            else {
                print("Cache fault for image")
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
    }
    
    private func saveImageInCache(data: Data?, response: URLResponse?, for request: URLRequest) {
        guard let data = data,
              let response = response
        else {
            return
        }
        
        let cacheToSave = CachedURLResponse(response: response, data: data)
        self.cache.storeCachedResponse(cacheToSave, for: request)
    }
}

