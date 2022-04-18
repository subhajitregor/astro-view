//
//  AstronomyTableCell.swift
//  astro-view
//
//  Created by Subhajit on 13/04/22.
//

import UIKit

protocol AstronomyTableCellData {
    var imageUrl: String? { get }
    var titleText: AttributedString? { get }
    var shortDescription: AttributedString? { get }
}

final class AstronomyTableCell: UITableViewCell, NibIdentifiable {
    
    @IBOutlet private var astronomyImageView: UIImageView!
    @IBOutlet private var astronomyTitle: UILabel!
    @IBOutlet private var astronomyShortDescription: UILabel!
    
    private var cellData: AstronomyTableCellData? {
        didSet {
            setupViews()
            setData()
        }
    }
    
    // MARK: Dependency Injector
    
    func setCellData(_ cellData: AstronomyTableCellData) {
        self.cellData = cellData
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

private extension AstronomyTableCell {
    
    func setupViews() {
        astronomyImageView.layer.cornerRadius = 10.0
        astronomyImageView.clipsToBounds = true
        astronomyImageView.contentMode = .scaleAspectFill
    }
    
    func setData() {
        astronomyImageView.loadImage(cellData?.imageUrl)
        astronomyTitle.attributedText = NSAttributedString(cellData?.titleText ?? "")
        astronomyShortDescription.attributedText = NSAttributedString(cellData?.shortDescription ?? "")
        
//        astronomyImageView.sizeToFit()
        astronomyTitle.sizeToFit()
        astronomyShortDescription.sizeToFit()
    }
}
