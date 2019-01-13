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
            
            guard let collection = collection else {
                return
            }
            
            setupThumbnailImage()
            textView.centerVertically()
            
            let attributedText = NSMutableAttributedString(string: collection.title!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20), NSForegroundColorAttributeName: Colours.indigoText])
            
            if let bodyText = collection.body_html {
                attributedText.append(NSAttributedString(string: "\n\n\(bodyText)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: Colours.indigoText]))
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText

        }
    }
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = Colours.indigoLight
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = collection?.thumbnailImageName {
            imageView.loadImageUsingUrlString(thumbnailImageUrl)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.white
        
        addSubview(imageView)
        addSubview(textView)
        addSubview(dividerLineView)
        
        _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 14, leftConstant: 14, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 100)
        _ = textView.anchor(topAnchor, left: imageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 14, bottomConstant: 0, rightConstant: 14, widthConstant: 0, heightConstant: 0)
        _ = dividerLineView.anchor(bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    
    }
    
}
