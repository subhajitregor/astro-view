//
//  ImageService.swift
//  astro-view
//
//  Created by Subhajit on 18/04/22.
//

import UIKit

protocol ImageServiceProtocol {
    func downloadImage(from urlString: String?, default image: UIImage?)
}

extension ImageServiceProtocol where Self: UIImageView {
    func downloadImage(from urlString: String?, default image: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            print("Invalid URL.")
            self.image = image
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let `self` = self else { return }
            guard let data = data else {
                print("Invalid Image Data recieved.")
                self.image = image
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        dataTask.resume()
    }
}

