//
//  CollectionDetailsHeaderCell.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-09.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

class CollectionDetailsHeaderCell: BaseCell {
    
    var collection: Collection? {
        didSet {
            setupThumbnailImage()
            
            titleLabel.text = collection?.title
            bodyLabel.text = collection?.body_html
            
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
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = Colours.shopifyPurple
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SAMPLETITLE"
        label.backgroundColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "SAMPLEBODY"
        label.backgroundColor = UIColor.yellow
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = collection?.thumbnailImageName {
            imageView.loadImageUsingUrlString(thumbnailImageUrl)
        }
    }
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.white
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(bodyLabel)
        
        _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 14, leftConstant: 14, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 100)
        _ = titleLabel.anchor(topAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 14, leftConstant: 14, bottomConstant: 0, rightConstant: 14, widthConstant: 0, heightConstant: 20)
        _ = bodyLabel.anchor(titleLabel.bottomAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 14, bottomConstant: 0, rightConstant: 14, widthConstant: 0, heightConstant: 50)
    
    }
    
}
