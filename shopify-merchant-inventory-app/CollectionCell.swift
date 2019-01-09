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
            titleLabel.text = collection?.title
            
            setupThumbnailImage()
            
            thumbnailImageView.image = UIImage(named: (collection?.thumbnailImageName)!)

            /*if let title = collection?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }*/
            
            
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        //imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: " ")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = collection?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
        }
    }
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        
        titleLabelHeightConstraint = titleLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 64)[3]
        _ = thumbnailImageView.anchor(topAnchor, left: leftAnchor, bottom: titleLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
