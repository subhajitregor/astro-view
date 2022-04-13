//
//  SceneBuilder.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import UIKit

protocol SceneBuilder {
    associatedtype Scene: UIViewController
    func build() -> Scene
}

