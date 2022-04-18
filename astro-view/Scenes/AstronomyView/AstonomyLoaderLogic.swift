//
//  AstonomyLoaderLogic.swift
//  astro-view
//
//  Created by Subhajit on 16/04/22.
//

import Foundation

protocol AstronomyLoaderLogic {
    func fetchAstronomy(completion: @escaping (Result<PicOfTheDay, Error>) -> ())
}
