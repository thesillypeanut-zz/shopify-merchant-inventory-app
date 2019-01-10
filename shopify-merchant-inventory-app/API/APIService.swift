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
                        collection.title = item["title"] as? String
                        
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
    
    
}
