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
    
    func testProductInformationAttributedHtmlString() {
        let productInformationTestString = "<p>Equipped with a variety of advanced features inside a sleek, integrated design, the S513K60X0G dishwasher from Neff will make doing the dishes easier than ever.</p>\r\r<p><strong>Energy efficient</strong><br>\rAwarded an excellent A++ for energy efficiency, you can rely on the S513K60X0G to help you save on your energy bills while keeping a green home.</p>\r\r<p><strong>DosageAssist</strong><br>\rThis useful function makes sure your detergent is completely dissolved for a more effective wash by releasing it into a special tray on top of the basket and mixing it into the cycle.</p>\r\r<p><strong>AquaSensor</strong><br>\rSaving water and energy, this feature automatically assesses how much water is needed, even during the rinsing stage, and will only use what's necessary.</p>\r\r<p><strong>Flexible loading</strong><br>\rThe S513K60X0G offers total flexibility with Neff's Flex basket and Vario drawer system. The top basket can be adjusted between 3 height positions and contains 2 foldable plate racks and 2 foldable cup shelves. Similarly, the bottom basket holds 4 foldable plate racks, while the Vario drawer offers extra storage on a third level.</p>\r\r<p><strong>Additional features and programmes:</strong><br>\r<ul>\r<li>Chef 70°C pro programme</li>\r<li>Aqua Stop</li>\r<li>Vario Speed Plus</li>\r<li>InfoLight status projection</li>\r\r<li>Efficient Drive</li>\r<li>Detergent Aware</li></ul></p>\r\r"
        
        var product = Product(productId: "1", title: "", priceData: [:], imageUrl: nil)
        product.productInformation = productInformationTestString
        
        XCTAssertNotNil(product.productInformationAttributedString)
    }
    
    func testProductDisplayAttributesForAttributeAtIndex() {
        
        var product = Product(productId: "1", title: "", priceData: [:], imageUrl: nil)
        product.attributes = [
            ["name": "some name", "value": "some value"],
            ["name": "some name 2", "value": "some value 2"]
        ]
        
        var data = product.displayPropertiesForAttribute(atIndex: 0)
        
        XCTAssertEqual(data.name, "some name")
        XCTAssertEqual(data.value, "some value")
        
        data = product.displayPropertiesForAttribute(atIndex: 1)
        
        XCTAssertEqual(data.name, "some name 2")
        XCTAssertEqual(data.value, "some value 2")
        
        data = product.displayPropertiesForAttribute(atIndex: 2)
        
        XCTAssertNil(data.name)
        XCTAssertNil(data.value)
    }
}
