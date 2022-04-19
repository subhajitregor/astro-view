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
    private var cache: PersistentCacheProtocol & CacheUpdateService {
        PersistentCache()
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
        
        cache.fetchFromCache(for: request) { [weak self] (result: (Result<CodableImage,Error>))  in
            guard let `self` = self else { return }
            switch result {
                
            case .success(let codableImage):
                DispatchQueue.main.async {
                    self.image = codableImage.image
                }
            case .failure:
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
                guard let data = data,
                      let image = UIImage(data: data)else {
                    print("Invalid Image Data recieved.")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                self.cache.saveInCache(data: data, response: response, for: request)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
}

