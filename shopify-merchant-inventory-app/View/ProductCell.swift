//
//  ProductCell.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-12.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

class ProductCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var variants: [Variant]?
    
    var product: Product? {
        didSet {
            
            guard let product = product else {
                return
            }
            
            setupImage()
            textView.centerVertically()
            detailTextView.centerVertically()
            self.variants = product.variants
            
            let attributedText = NSMutableAttributedString(string: product.title!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20), NSForegroundColorAttributeName: Colours.indigoText])
            
            attributedText.append(NSAttributedString(string: "\n\(product.bodyHtml!)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: Colours.indigoText]))
            
            textView.attributedText = attributedText
            
            detailTextView.text = "Product type: \(product.productType!)\nVendor: \(product.vendor!)\nTags: \(product.tags!)"
            
            let inventoryLabel = String(product.totalInventory!)
            inventoryQuantityLabel.text = inventoryLabel
            
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedRect = NSString(string: inventoryLabel).boundingRect(with: CGSize(width: 1000, height: 20), options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)], context: nil)
                
            if estimatedRect.size.width > 20 {
                labelWidthConstraint?.constant = 40
            } else {
                labelWidthConstraint?.constant = 30
            }
            
        }
    }
    
    let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = Colours.greenLight
        imageView.image = UIImage(named: "SAMPLEIMAGE")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    func setupImage() {
        if let imageUrl = product?.imageName {
            imageView.loadImageUsingUrlString(imageUrl)
        }
    }
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    let detailTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        tv.backgroundColor = Colours.greenLighter
        tv.textColor = Colours.greenText
        return tv
    }()
    
    let inventoryQuantityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Colours.greenDark
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SAMPLETEXT"
        label.font = label.font.withSize(12)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    let inventoryImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "package"))
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.clipsToBounds = true
        return iv
    }()
    
    let dividerLineView: [UIView] = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        
        let view2 = UIView()
        view2.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return [view, view2]
    }()
    
    fileprivate let cellId = "cellId"
    fileprivate let titleId = "titleId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (variants?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! VariantTitleCell
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VariantCell
        cell.variant = variants?[indexPath.item-1]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: 82, height: 82)
        }
        
        return CGSize(width: 120, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(14, 14, 14, 14)
    }
    
    fileprivate class VariantTitleCell: BaseCell {
        
        let textView: UITextView = {
            let tv = UITextView()
            tv.isEditable = false
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.isScrollEnabled = false
            tv.isUserInteractionEnabled = false
            tv.textColor = UIColor.white
            tv.backgroundColor = UIColor.clear
            tv.font = UIFont.systemFont(ofSize: 16)
            tv.textAlignment = .center
            tv.text = "Product Variants"
            return tv
        }()
        
        override func setupViews() {
            super.setupViews()
            
            backgroundColor = Colours.greenDark
            layer.cornerRadius = 16
            
            addSubview(textView)
            
            _ = textView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            
        }
    }
    
    fileprivate class VariantCell: BaseCell {
        
        var variant: Variant? {
            didSet {
                
                guard let variant = variant else {
                    return
                }
                
                textView.centerVertically()
                
                let attributedText = NSMutableAttributedString(string: variant.title!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: Colours.greenDark])
                
                attributedText.append(NSAttributedString(string: "\nPrice: \(variant.price!)\nWeight: \(variant.weight!)\n Quantity: \(String(variant.inventoryQuantity!))", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: Colours.greenDark]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                
                let length = attributedText.string.characters.count
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
                
                textView.attributedText = attributedText

            }
        }
        
        let textView: UITextView = {
            let tv = UITextView()
            tv.isEditable = false
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.isScrollEnabled = false
            tv.isUserInteractionEnabled = false
            tv.textColor = Colours.greenDark
            tv.layer.borderWidth = 1
            tv.layer.cornerRadius = 16
            tv.layer.borderColor = Colours.greenDark.cgColor
            return tv
        }()

        override func setupViews() {
            super.setupViews()
            
            addSubview(textView)
            
            _ = textView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            
        }
    }
    
    var labelWidthConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(textView)
        addSubview(detailTextView)
        addSubview(inventoryImageView)
        addSubview(inventoryQuantityLabel)
        addSubview(collectionView)
        addSubview(dividerLineView[0])
        addSubview(dividerLineView[1])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        _ = collectionView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 110)
        
        _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 14, leftConstant: 14, bottomConstant: 0, rightConstant: 0, widthConstant: 82, heightConstant: 120)
        
        _ = textView.anchor(topAnchor, left: imageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 14, leftConstant: 14, bottomConstant: 14, rightConstant: 14, widthConstant: 0, heightConstant: 60)
        
        _ = detailTextView.anchor(textView.bottomAnchor, left: imageView.rightAnchor, bottom: collectionView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 14, bottomConstant: 14, rightConstant: 14, widthConstant: 0, heightConstant: 0)
        
        _ = inventoryImageView.anchor(nil, left: nil, bottom: detailTextView.bottomAnchor, right: detailTextView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 30, heightConstant: 30)
        
        labelWidthConstraint = inventoryQuantityLabel.anchor(nil, left: nil, bottom: inventoryImageView.topAnchor, right: detailTextView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: -5, rightConstant: 5, widthConstant: 30, heightConstant: 20)[2]
        inventoryQuantityLabel.centerXAnchor.constraint(equalTo: inventoryImageView.centerXAnchor).isActive = true
        
        _ = dividerLineView[0].anchor(nil, left: leftAnchor, bottom: collectionView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        _ = dividerLineView[1].anchor(bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        collectionView.register(VariantTitleCell.self, forCellWithReuseIdentifier: titleId)
        collectionView.register(VariantCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}
