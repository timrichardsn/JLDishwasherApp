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
        productDetailView.viewWillAppear(true)
        
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
    
    func testViewRefreshCalledWhenIsLandscapeIsChangedToDifferentValue() {
        
        let presenter = ProductDetailPresenter()
        
        let view = MockProductView()
        
        presenter.view = view
        
        presenter.isLandscape = true
        XCTAssertTrue(view.refreshCalled)
        
        // reset
        view.refreshCalled = false
        
        presenter.isLandscape = true
        XCTAssertFalse(view.refreshCalled)
        
        presenter.isLandscape = false
        XCTAssertTrue(view.refreshCalled)
    }
    
    func testFetchProductDataCalledInPresenterViewDidLoad() {
        
        let presenter = ProductDetailPresenter()
        let interactor = MockProductInteractor()
        
        presenter.interactor = interactor
        presenter.viewDidLoad()
        
        XCTAssertTrue(interactor.fetchProductDataCalled)
    }
}

private class MockProductDetailPresenter: ProductDetailViewPresenterProtocol {
    
    var view: ProductDetailViewProtocol?
    var router: ProductDetailRouterProtocol?
    var product: Product?
    var isLandscape: Bool?
    
    var viewWillAppearWasCalled = false
    
    func viewWillAppear() {
        viewWillAppearWasCalled = true
    }
    
    func viewDidLoad() {
        
    }
}

private class MockProductView: ProductDetailViewProtocol {
    var presenter: ProductDetailViewPresenterProtocol?
    
    var refreshCalled = false
    
    func refresh() {
        refreshCalled = true
    }
}

private class MockProductInteractor: ProductDetailInteractorProtocol {
    
    var fetchProductDataCalled = false
    
    func fetchProductData(for product: Product) {
        fetchProductDataCalled = true
    }
}
