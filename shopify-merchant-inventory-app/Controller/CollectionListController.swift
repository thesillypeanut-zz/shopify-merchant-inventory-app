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
    
    fileprivate let cellId =  "cellId"
    
    func fetchCollections() {
        APIService.sharedInstance.fetchCollections { (collections: [Collection]) in
            
            self.collections = collections
            self.collectionView?.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCollections()
        
        navigationItem.title = "Collections"
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Collections"
        titleLabel.textColor = Colours.indigoText
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionCell
        
        cell.collection = collections?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((view.frame.width)/2)-15, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let collectionDetailsController = CollectionDetailsController(collectionViewLayout: layout)
        
        guard let collection = collections?[indexPath.item] else { return }
        
        collectionDetailsController.collection = collection
        navigationController?.pushViewController(collectionDetailsController, animated: true)
    }
    
}
