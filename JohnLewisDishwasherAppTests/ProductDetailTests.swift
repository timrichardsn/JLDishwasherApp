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
        
        let product = Product(productId: "1", title: "", priceData: [:], imageUrl: "")
        let productDetailView = ProductDetailRouter.createProductDetailModule(for: product) as! ProductDetailViewProtocol
        
        XCTAssertNotNil(productDetailView.presenter)
        XCTAssertNotNil(productDetailView.presenter?.view)
        XCTAssertNotNil(productDetailView.presenter?.router)
        XCTAssertNotNil(productDetailView.presenter?.product)
        XCTAssertNotNil(productDetailView.presenter?.interactor)
        XCTAssertNotNil(productDetailView.presenter?.interactor?.remoteDataManager)
        XCTAssertNotNil(productDetailView.presenter?.interactor?.presenter)
        XCTAssertNotNil(productDetailView.presenter?.interactor?.remoteDataManager?.remoteDataOutputHandler)
        XCTAssertEqual(productDetailView.presenter?.product?.productId, product.productId)
    }
    
    func testPresenterViewDidLoadAndAppearCalled() {
        
        let product = Product(productId: "1", title: "", priceData: [:], imageUrl: "")
        let productDetailView = ProductDetailRouter.createProductDetailModule(for: product) as! ProductDetailView
        
        let presenter = MockProductDetailPresenter()
        
        productDetailView.presenter = presenter
        productDetailView.viewWillAppear(true)
        
        XCTAssertTrue(presenter.viewWillAppearWasCalled)
    }
    
    func testPresenterIsLandscapeIsSetInViewDidLoad() {
        
        let product = Product(productId: "1", title: "", priceData: [:], imageUrl: "")
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
    
    func testFetchProductDataCallsPerformRequestOnRemoteDataManager() {
        
        let dataManager = MockDataManager()
        let interactor = ProductDetailInteractor()
        interactor.remoteDataManager = dataManager
        
        interactor.fetchProductData(for: Product(productId: "1", title: "", priceData: [:], imageUrl: ""))
        
        XCTAssertTrue(dataManager.performRequestCalled)
    }
}

private class MockProductDetailPresenter: ProductDetailViewPresenterProtocol {
    
    var interactor: ProductDetailInteractorProtocol?
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
    
    var presenter: ProductDetailViewPresenterProtocol?
    var remoteDataManager: ProductDetailRemoteDataProtocol?
    var fetchProductDataCalled = false
    
    func fetchProductData(for product: Product) {
        fetchProductDataCalled = true
    }
}

private class MockDataManager: ProductDetailRemoteDataProtocol {
    
    var remoteDataOutputHandler: ProductDetailRemoteDataOutputProtocol?
    var performRequestCalled = false
    
    func performRequest(with requestData: RequestData) {
        performRequestCalled = true
    }
}
