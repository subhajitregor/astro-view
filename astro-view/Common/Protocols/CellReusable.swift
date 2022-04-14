//
//  CellReusable.swift
//  astro-view
//
//  Created by Subhajit on 14/04/22.
//

import Foundation

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension CellReusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

