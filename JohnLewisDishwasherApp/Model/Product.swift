//
//  Product.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 18/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

struct Product {
    let productId: String
    let title: String
    let imageUrl: String
    let price: String
    
    init(productId: String, title: String, imageUrl: String, priceData: [String: String]) {
        self.productId = productId
        self.title = title
        self.imageUrl = imageUrl
        self.price = priceData["now"] ?? "0"
    }
}

extension Product {
    var priceString: String {
        return "£\(price)"
    }
}
