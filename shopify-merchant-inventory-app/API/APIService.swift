//
//  APIService.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-09.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

class APIService: NSObject {
    
    static let sharedInstance = APIService()
    
    let baseUrl = "https://shopicruit.myshopify.com/admin"
    
    func fetchCollections(_ completion: @escaping ([Collection]) -> ()) {
        let url = URL(string: "\(baseUrl)/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error ?? "Error encountered while fetching collections from Shopify Custom Collections API.")
                return
            }
            
            do {
                if let unwrappedData = data, let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String: Any], let collection_items = json["custom_collections"] as? [[String: Any]] {
                    
                    var collections = [Collection]()
                    
                    for item in collection_items {
                        let collection = Collection()
                        let image = item["image"] as? [String: Any]
                        
                        collection.thumbnailImageName = image?["src"] as? String
                        collection.title = (item["title"] as? String)?.capitalized
                        collection.body_html = item["body_html"] as? String
                        collection.id = item["id"] as? Int64
                        
                        collections.append(collection)
                    }
                    
                    DispatchQueue.main.async(execute: {
                        completion(collections)
                    })
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }).resume()
    }
    
    fileprivate func fetchProductIdsFromCollects(_ collectionId: Int64, _ completion: @escaping (String) -> ()) {
        let collectUrl = URL(string: "\(baseUrl)/collects.json?collection_id=\(collectionId)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        
        var request = URLRequest(url: collectUrl!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error ?? "Error encountered while fetching collects from Shopify Custom Collections API.")
                return
            }
            
            do {
                if let unwrappedData = data, let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String: Any], let collects = json["collects"] as? [[String: Any]] {
                    
                    var productIds = [String]()
                    
                    for collect in collects {
                        productIds.append(String(describing: collect["product_id"] as! Int64))
                    }
                    
                    DispatchQueue.main.async(execute: {
                        completion(productIds.joined(separator: ","))
                    })
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }).resume()
    }
    
    func fetchProducts(_ collectionId: Int64, _ completion: @escaping ([Product]) -> ()) {
        
        APIService.sharedInstance.fetchProductIdsFromCollects(collectionId) { (productIds: String) in
            
            let url = URL(string: "\(self.baseUrl)/products.json?ids=\(productIds)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
            
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error ?? "Error encountered while fetching collections from Shopify Custom Collections API.")
                    return
                }
                
                do {
                    if let unwrappedData = data, let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String: Any], let product_items = json["products"] as? [[String: Any]] {
                        
                        var products = [Product]()
                        
                        for item in product_items {
                            let product = Product()
                            
                            let image = item["image"] as? [String: Any]
                            
                            product.imageName = image?["src"] as? String
                            product.title = item["title"] as? String
                            product.body_html = item["body_html"] as? String
                            product.vendor = item["vendor"] as? String
                            product.product_type = item["productType"] as? String
                            product.tags = item["tags"] as? String
                            
                            var variants = [Variant]()
                            let variant_items = item["variants"] as! [[String: Any]]
                            var totalInventory: Int = 0
                            
                            for item in variant_items {
                                let variant = Variant()
                            
                                variant.title = item["title"] as? String
                                variant.price = item["price"] as? String
                                variant.weight = String(item["weight"] as! Float) + (item["weight_unit"] as! String)
                            
                                let inventoryQuantity = item["inventory_quantity"] as! Int
                                variant.inventoryQuantity = inventoryQuantity
                                totalInventory += inventoryQuantity
                            
                                variants.append(variant)
                            }
                            
                            product.variants = variants
                            product.totalInventory = totalInventory
                            
                            products.append(product)
                            
                        }
                        
                        DispatchQueue.main.async(execute: {
                            completion(products)
                        })
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
            }).resume()
            
        }
        
    }
    
}
