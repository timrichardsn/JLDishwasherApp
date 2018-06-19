//
//  ProductDetailTests.swift
//  JohnLewisDishwasherAppTests
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import XCTest
@testable import JohnLewisDishwasherApp

class ProductDetailTests: XCTestCase {
    
    func testProductDetailModule() {
        
        let product = Product(productId: "1", title: "", imageUrl: "", priceData: [:])
        let productDetailView = ProductDetailRouter.createProductDetailModule(for: product) as! ProductDetailViewProtocol
        
        XCTAssertNotNil(productDetailView.presenter)
        XCTAssertNotNil(productDetailView.presenter?.view)
        XCTAssertNotNil(productDetailView.presenter?.router)
        XCTAssertNotNil(productDetailView.presenter?.product)
        XCTAssertEqual(productDetailView.presenter?.product?.productId, product.productId)
    }
    
    func testPresenterViewDidLoadAndAppearCalled() {
        
        let product = Product(productId: "1", title: "", imageUrl: "", priceData: [:])
        let productDetailView = ProductDetailRouter.createProductDetailModule(for: product) as! ProductDetailView
        
        let presenter = MockProductDetailPresenter()
        
        productDetailView.presenter = presenter
        productDetailView.view.setNeedsLayout()
        productDetailView.viewDidAppear(true)
        
        XCTAssertTrue(presenter.viewDidLoadWasCalled)
        XCTAssertTrue(presenter.viewDidLoadWasCalled)
    }
}

private class MockProductDetailPresenter: ProductDetailViewPresenterProtocol {
    var view: ProductDetailViewProtocol?
    var router: ProductDetailRouterProtocol?
    var product: Product?
    
    var viewDidLoadWasCalled = false
    var viewDidAppearWasCalled = false
    
    func viewDidLoad() {
        viewDidLoadWasCalled = true
    }
    
    func viewDidAppear() {
        viewDidAppearWasCalled = true
    }
}
