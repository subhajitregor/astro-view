//
//  UIStoryboard+Extentions.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import UIKit

extension UIStoryboard {
    static func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        UIStoryboard.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func createViewController<VC: UIViewController>() -> VC where VC: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC else {
            fatalError("Couldn't find view controller with identifier: \(VC.storyboardIdentifier) in Storyboard: \(String(describing: self))")
        }
        
        return viewController
    }
}

