//
//  CodableImage.swift
//  astro-view
//
//  Created by Subhajit on 19/04/22.
//

import Foundation
import UIKit

struct CodableImage: Codable {
    let image: UIImage
    
    public enum CodingKeys: String, CodingKey {
        case image
    }
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.image)
        guard let image = UIImage(data: data) else {
            throw CacheError.decodingFailed
        }
        
        self.image = image
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let data = image.pngData() else {
            throw CacheError.encodingFailed
        }
        
        try container.encode(data, forKey: CodingKeys.image)
    }
}
