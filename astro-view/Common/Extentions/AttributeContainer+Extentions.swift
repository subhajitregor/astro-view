//
//  AttributeContainer+Extentions.swift
//  astro-view
//
//  Created by Subhajit on 18/04/22.
//

import UIKit

extension AttributeContainer {
    static let titleAttributeContainer : AttributeContainer = {
        AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
    }()
    
    static let descriptionAttributeContainer: AttributeContainer = {
        AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
    }()
}
