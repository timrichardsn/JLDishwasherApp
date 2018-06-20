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
    
    func testProductUIDisplay() {
        
        var product = Product(productId: "1", title: "", priceData: [:], imageUrl: "")
        product.displaySpecialOffer = "Some special offer"
        product.guaranteeInformation = ["2 years"]
        
        let productDetailView = ProductDetailRouter.createProductDetailModule(for: product) as! ProductDetailView
        
        let presenter = MockProductDetailPresenter()
        presenter.product = product
        
        productDetailView.presenter = presenter
        
        productDetailView.view.setNeedsLayout()
        productDetailView.refresh()
        
        XCTAssertEqual(productDetailView.priceLabel.text, product.priceString)
        XCTAssertEqual(productDetailView.specialOffer.text, product.displaySpecialOffer ?? "")
        XCTAssertEqual(productDetailView.guarantee.text, product.guaranteeInformation?.first ?? "")
    }
    
    func testPresenterNumberOfSections() {
        
        let presenter = ProductDetailPresenter()
        
        XCTAssertEqual(presenter.numberOfSections, 3)
    }
    
    func testNumberOfRowsInSection() {
        
        var product = Product(productId: "", title: "", priceData: [:], imageUrl: nil)
        product.attributes = [
            [:], [:], [:]
        ]
        
        let presenter = ProductDetailPresenter()
        presenter.product = product
        presenter.isLandscape = true
        
        XCTAssertEqual(presenter.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(presenter.numberOfRows(inSection: 1), 1)
        XCTAssertEqual(presenter.numberOfRows(inSection: 2), product.attributes?.count)
        
        presenter.isLandscape = false
        
        XCTAssertEqual(presenter.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(presenter.numberOfRows(inSection: 1), 1)
        XCTAssertEqual(presenter.numberOfRows(inSection: 2), product.attributes?.count)
    }
    
    func testHeightForRowAtIndexPath() {
        
        let presenter = ProductDetailPresenter()
        
        // nil constitutes automatic cell height calculation, i.e. dynamic
        XCTAssertEqual(presenter.heightForCellAt(row: 0, section: 0), 500)
        XCTAssertNil(presenter.heightForCellAt(row: 1, section: 0))
        XCTAssertEqual(presenter.heightForCellAt(row: 0, section: 2), 60)
        XCTAssertNil(presenter.heightForCellAt(row: 0, section: 1))
    }
    
    func testTitleHeaderForSection() {
        let presenter = ProductDetailPresenter()
        
        XCTAssertNil(presenter.titleForHeaderIn(section: 0))
        XCTAssertEqual(presenter.titleForHeaderIn(section: 1), "Product information")
        XCTAssertEqual(presenter.titleForHeaderIn(section: 2), "Product specification")
    }
    
    func testHeaderHeightForSection() {
        let presenter = ProductDetailPresenter()
        
        XCTAssertNil(presenter.heightForHeaderIn(section: 0))
        XCTAssertEqual(presenter.heightForHeaderIn(section: 1), 100)
        XCTAssertEqual(presenter.heightForHeaderIn(section: 2), 100)
    }
}

private class MockProductDetailPresenter: ProductDetailViewPresenterProtocol {
    
    var numberOfSections: Int = 3
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
    
    func numberOfRows(inSection section: Int) -> Int {
        return 0
    }
    
    func heightForCellAt(row: Int, section: Int) -> Int? {
        return nil
    }
    
    func titleForHeaderIn(section: Int) -> String? {
        return nil
    }
    
    func heightForHeaderIn(section: Int) -> Int? {
        return nil
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
