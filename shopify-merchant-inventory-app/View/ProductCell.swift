//
//  ProductCell.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-12.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

class ProductCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var product: Product? {
        didSet {
            //titleLabel.text = collection?.title
            
            setupImage()
            
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
        let imageView = CustomImageView()
        //imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "SAMPLEIMAGE")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupImage() {
        if let imageUrl = product?.imageName {
            imageView.loadImageUsingUrlString(imageUrl)
        }
    }
    
    fileprivate let cellId = "cellId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.red
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 0, 10, 0)
    }
    
    fileprivate class VariantCell: BaseCell {
        
        let imageView: CustomImageView = {
            let iv = CustomImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = UIColor.green
            return iv
        }()
        
        override func setupViews() {
            super.setupViews()
            
            addSubview(imageView)
            
            _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = collectionView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 120)
        
        backgroundColor = UIColor.blue
        
        collectionView.register(VariantCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}
