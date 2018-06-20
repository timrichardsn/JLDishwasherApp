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
    let price: String
    
    var imageUrl: String?
    var urls: [String]?
    var productInformation: String?
    var displaySpecialOffer: String?
    var guaranteeInformation: [String]?
    var code: String?
    var attributes: [[String: Any]]?
    
    init(productId: String, title: String, priceData: [String: String], imageUrl: String?) {
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
    
    var productCodeDisplayString: String {
        return "Product code: \(code ?? "")"
    }
    
    var productInformationAttributedString: NSAttributedString? {
        
        if let attributedStringData = productInformation?.data(using: .unicode) {
            
            return try? NSAttributedString(data: attributedStringData,
                                           options: [.documentType: NSAttributedString.DocumentType.html],
                                           documentAttributes: nil)
        }
        
        return nil
    }
}
