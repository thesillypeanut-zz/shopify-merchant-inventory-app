//
//  CustomImageView.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-09.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(_ urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "Error encountered when loading image from url string.")
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            })
            
        }).resume()
    }
    
}
