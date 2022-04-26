//
//  albumCollectionViewCell.swift
//  myAlbums
//
//  Created by apple on 24/04/2022.
//

import UIKit

class albumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView : UIImageView!
    static var identifier = "albumCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with image : UIImage) {
        imageView.image = image
        
    }
    static func nib()-> UINib {
        return UINib(nibName: "albumCollectionViewCell", bundle: nil)
    }
}
