//
//  CollectionCell.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-08.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

class CollectionCell: BaseCell {
    
    var collection: Collection? {
        didSet {
            
            guard let collection = collection else {
                return
            }
            
            titleLabel.text = collection.title
            setupThumbnailImage()
            
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = Colours.indigoLight
        imageView.image = UIImage(named: "SAMPLEIMAGE")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Colours.indigo
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SAMPLETEXT"
        label.font = label.font.withSize(16)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.clipsToBounds = true
        return label
    }()
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = collection?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        
        _ = titleLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        _ = thumbnailImageView.anchor(topAnchor, left: leftAnchor, bottom: titleLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
