//
//  Product.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 18/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation
import UIKit

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
        
        if let attributedStringData = productInformation?.data(using: .utf8) {
            
            if let attrString = try? NSMutableAttributedString(data: attributedStringData,
                                           options: [.documentType: NSAttributedString.DocumentType.html],
                                           documentAttributes: nil) {
                
                var attrs = attrString.attributes(at: 0, effectiveRange: nil)
                attrs[.font] = UIFont.systemFont(ofSize: 17)
                attrString.setAttributes(attrs, range: NSRange(location: 0, length: attrString.length))
                
                return attrString
            }
        }
        
        return nil
    }
    
    func displayPropertiesForAttribute(atIndex index: Int) -> (name: String?, value: String?) {
        
        if (attributes?.count ?? 0) > index, let attribute = attributes?[index] {
            return (attribute["name"] as? String, attribute["value"] as? String)
        }
        
        return (nil, nil)
    }
}
