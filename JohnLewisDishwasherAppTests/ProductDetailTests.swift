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
        productDetailView.viewWillAppear(true)
        
        XCTAssertTrue(presenter.viewDidLoadWasCalled)
        XCTAssertTrue(presenter.viewWillAppearWasCalled)
    }
    
    func testPresenterIsLandscapeIsSetInViewDidLoad() {
        
        let product = Product(productId: "1", title: "", imageUrl: "", priceData: [:])
        let productDetailView = ProductDetailRouter.createProductDetailModule(for: product) as! ProductDetailView
        
        let presenter = MockProductDetailPresenter()
        
        productDetailView.presenter = presenter
        productDetailView.view.setNeedsLayout()
        
        XCTAssertNotNil(presenter.isLandscape)
    }
    
    func testViewShowProductInPresenterViewDidLoad() {
        
        let presenter = ProductDetailPresenter()
        let view = MockProductView()
        let product = Product(productId: "1", title: "", imageUrl: "", priceData: [:])
        
        presenter.view = view
        presenter.product = product
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showProductCalled)
        XCTAssertEqual(view.showProduct?.productId, product.productId)
    }
    
}

private class MockProductDetailPresenter: ProductDetailViewPresenterProtocol {
    var view: ProductDetailViewProtocol?
    var router: ProductDetailRouterProtocol?
    var product: Product?
    var isLandscape: Bool?
    
    var viewDidLoadWasCalled = false
    var viewWillAppearWasCalled = false
    
    func viewDidLoad() {
        viewDidLoadWasCalled = true
    }
    
    func viewWillAppear() {
        viewWillAppearWasCalled = true
    }
}

private class MockProductView: ProductDetailViewProtocol {
    var presenter: ProductDetailViewPresenterProtocol?
    
    var showProductCalled = false
    var showProduct: Product?
    
    func show(product: Product) {
        showProductCalled = true
        showProduct = product
    }
}
