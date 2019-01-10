//
//  CollectionListController.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-08.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

class CollectionListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var collections: [Collection]?
    
    func fetchCollections() {
        APIService.sharedInstance.fetchCollections { (collections: [Collection]) in
            
            self.collections = collections
            self.collectionView?.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCollections()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor.white
        //collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        //collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionCell
        
        cell.collection = collections?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width)/2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
