//
//  Product.swift
//  shopify-merchant-inventory-app
//
//  Created by Maliha Islam on 2019-01-10.
//  Copyright © 2019 Maliha Islam. All rights reserved.
//

import UIKit

class Product: NSObject {
    
    var imageName: String?
    var title: String?
    var bodyHtml: String?
    var vendor: String?
    var productType: String?
    var tags: String?
    var variants: [Variant]?
    var totalInventory: Int?
    
}

