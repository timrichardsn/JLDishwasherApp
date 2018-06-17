//
//  ProductGridTests.swift
//  JohnLewisDishwasherAppTests
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import XCTest
@testable import JohnLewisDishwasherApp

class ProductGridTests: XCTestCase {
    
    func testCreateProductGridView() {
        
        let productsNavigationController = ProductGridRouter.createProductGridModule()
        
        XCTAssertTrue(productsNavigationController.childViewControllers.first is ProductGridView)
    }
    
    

}
