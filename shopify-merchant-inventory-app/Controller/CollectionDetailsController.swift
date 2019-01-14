//
//  CollectionDetailsController.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-09.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

class CollectionDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var products: [Product]?
    
    var collection: Collection? {
        didSet {
            APIService.sharedInstance.fetchProducts((collection?.id)!) { (products: [Product]) in
                
                self.products = products
                self.collectionView?.reloadData()
                
            }
            
        }
    }
    
    fileprivate let headerId = "headerId"
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CollectionDetailsHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        
        cell.product = products?[indexPath.item]
        
        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 258)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CollectionDetailsHeaderCell
        header.collection = collection
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(14, 14, 14, 14)
    }
    
}
