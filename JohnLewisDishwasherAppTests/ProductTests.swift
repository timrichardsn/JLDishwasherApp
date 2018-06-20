//
//  ProductTests.swift
//  JohnLewisDishwasherAppTests
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import XCTest
@testable import JohnLewisDishwasherApp

class ProductTests: XCTestCase {
    
    func testProductInitialiser() {
        
        let productId = "123"
        let productTitle = "product title"
        let imageUrl = "https://someurl.com"
        var priceData: [String: String] = [:]
        
        var product = Product(productId: productId, title: productTitle, priceData: priceData, imageUrl: imageUrl)
        
        XCTAssertEqual(product.productId, productId)
        XCTAssertEqual(product.title, productTitle)
        XCTAssertEqual(product.imageUrl, imageUrl)
        XCTAssertEqual(product.price, "0")
        XCTAssertEqual(product.priceString, "£0")
        
        priceData = ["now": "123"]
        
        product = Product(productId: productId, title: productTitle, priceData: priceData, imageUrl: imageUrl)
        
        XCTAssertEqual(product.price, "123")
        XCTAssertEqual(product.priceString, "£123")
    }
    
    func testProductCodeDisplayString() {
        
        var product = Product(productId: "1", title: "", priceData: [:], imageUrl: nil)
        product.code = "123"
        
        XCTAssertEqual(product.productCodeDisplayString, "Product code: \(product.code!)")
    }
}
