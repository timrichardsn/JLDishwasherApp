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
    
    func testProductGridModule() {
        
        let productsNavigationController = ProductGridRouter.createProductGridModule()
        
        XCTAssertTrue(productsNavigationController.childViewControllers.first is ProductGridView)
        
        let productGridView = productsNavigationController.childViewControllers.first as! ProductGridView
        let presenter = productGridView.presenter
        let interactor = presenter?.interactor
        
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.view)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(presenter?.router)
        XCTAssertNotNil(interactor?.presenter)
        XCTAssertNotNil(interactor?.remoteDataManager)
        
        XCTAssert(interactor?.presenter === presenter)
        XCTAssert(interactor?.remoteDataManager?.remoteDataOutputHandler === interactor)
    }
    
    func testPresenterViewDidLoadCalled() {
        
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as? ProductGridView
        let presenter = MockProductGridPresenter()
        
        productGridView?.presenter = presenter
        
        productGridView?.view.setNeedsLayout()
        
        XCTAssertTrue(presenter.viewDidLoadWasCalled)
    }
    
    func testPresenterViewDidAppearCalled() {
        
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as? ProductGridView
        let presenter = MockProductGridPresenter()
        
        productGridView?.presenter = presenter
        productGridView?.view.setNeedsLayout()
        productGridView?.viewDidAppear(true)
        
        XCTAssertTrue(presenter.viewDidAppearWasCalled)
    }
    
    func testInteractorFetchProductsCalled() {
        
        let presenter = ProductGridPresenter()
        let interactor = MockProductGridInteractor()
        
        presenter.interactor = interactor
        presenter.viewDidLoad()
        
        XCTAssertTrue(interactor.fetchProductsWasCalled)
    }
    
    func testDataManagerFetchProductsCalled() {
        
        let interactor = ProductGridInteractor()
        let remoteDataManager = MockProductRemoteDataManager()
        
        interactor.remoteDataManager = remoteDataManager
        interactor.fetchProducts()
        
        XCTAssertTrue(remoteDataManager.performRequestWasCalled)
        XCTAssertNotNil(remoteDataManager.requestData)
    }
    
    func testRequestData() {
        
        let parameters: [RequestParameterKey: Any] = [
            .product : "dishwasher",
            .pageSize: "20"
        ]
        
        let requestData = RequestData(endPoint: .products(action: .search), parameters: parameters)
        
        XCTAssertEqual(requestData.endPoint.endpointString, "products/search")
        XCTAssertEqual(requestData.endPoint.urlString, "\(API.rootUrlString)/products/search")
        XCTAssertNotNil(requestData.parameters)
        
        let parametersForRequest = requestData.parametersForRequest(includeKey: true)
        
        XCTAssertEqual(parametersForRequest.count, 3)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.product.stringValue] as? String, parameters[.product] as? String)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.pageSize.stringValue] as? String, parameters[.pageSize] as? String)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.key.stringValue] as? String, API.key)
    }
    
    func testRequestParameters() {
        
        XCTAssertEqual(RequestParameterKey.product.stringValue, "q")
        XCTAssertEqual(RequestParameterKey.key.stringValue, "key")
        XCTAssertEqual(RequestParameterKey.pageSize.stringValue, "pageSize")
    }
    
    func testPerformRequestCallbackCalledWithProducts() {
        
        let remoteDataManager = ProductGridRemoteDataManager()
        let mockRemoteDataOutput = MockProductRemoteDataOutput()
        let mockNetworkDataRequest = MockNetworkDataRequest()
        
        remoteDataManager.remoteDataOutputHandler = mockRemoteDataOutput
        
        let parameters: [RequestParameterKey: Any] = [.product : "dishwasher", .pageSize: "20"]
        let requestData = RequestData(endPoint: .products(action: .search), parameters: parameters)
        
        remoteDataManager.performRequest(with: requestData, networkDataRequest: mockNetworkDataRequest)
        
        XCTAssertTrue(mockRemoteDataOutput.onProductsReceivedCalled)
        XCTAssertNotNil(mockRemoteDataOutput.products)
    }
    
    func testInteractorCallsDidReceiveProducts() {
        
        let interactor = ProductGridInteractor()
        let mockPresenter = MockProductGridPresenter()
        interactor.presenter = mockPresenter
        
        interactor.onProductsReceived(products: [])
        
        XCTAssertTrue(mockPresenter.didReceiveProductsCalled)
    }
    
    func testShowProducts() {
        
        let presenter = ProductGridPresenter()
        let view = MockProductGridView()
        
        presenter.view = view
        presenter.didReceive(products: [])
        
        XCTAssertTrue(view.showProductsCalled)
    }
    
    func testProductsCountOnView() {
        
        let presenter = ProductGridPresenter()
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as! ProductGridView
        
        let products = [
            Product(productId: "", title: "", imageUrl: "", priceData: [:]),
            Product(productId: "", title: "", imageUrl: "", priceData: [:]),
            Product(productId: "", title: "", imageUrl: "", priceData: [:]),
            Product(productId: "", title: "", imageUrl: "", priceData: [:]),
            Product(productId: "", title: "", imageUrl: "", priceData: [:])
        ]
        
        productGridView.presenter = presenter
        
        presenter.didReceive(products: products)
        
        productGridView.view.setNeedsLayout()
        
        let productsCount = productGridView.collectionView(productGridView.collectionView!, numberOfItemsInSection: 0)
        XCTAssertEqual(productsCount, products.count)
    }
    
    func testPresenterProductReturn() {
        
        let presenter = ProductGridPresenter()
        
        let products = [
            Product(productId: "1", title: "", imageUrl: "", priceData: [:]),
            Product(productId: "2", title: "", imageUrl: "", priceData: [:]),
            Product(productId: "3", title: "", imageUrl: "", priceData: [:]),
            Product(productId: "4", title: "", imageUrl: "", priceData: [:]),
            Product(productId: "5", title: "", imageUrl: "", priceData: [:])
        ]
        
        presenter.didReceive(products: products)
        
        let indexPath = IndexPath(row: 2, section: 0)
        let product = presenter.product(at: indexPath)
        
        XCTAssertEqual(product.productId, products[indexPath.row].productId)
    }
    
    func testCellSizeCalculation() {
        
        // Cell width should be 1/4 of the container width, height 1/2 of the container width (locked to landscape)
        let presenter = ProductGridPresenter()
        
        let collectionViewSize = Size(100, 50)
        let indexPath = IndexPath(row: 0, section: 0)
        
        let cellSize = presenter.cellSizeFrom(collectionViewSize: collectionViewSize, at: indexPath)
        
        XCTAssertEqual(cellSize.width, collectionViewSize.width / 4)
        XCTAssertEqual(cellSize.height, collectionViewSize.height / 2)
    }
    
    func testPresenterCellSizeIsCalled() {
        
        let presenter = MockProductGridPresenter()
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as! ProductGridView
        let indexPath = IndexPath(row: 0, section: 0)
        
        productGridView.presenter = presenter
        productGridView.view.setNeedsLayout()
        
        let collectionView = productGridView.collectionView
        
        _ = productGridView.collectionView(collectionView!, layout: collectionView!.collectionViewLayout, sizeForItemAt: indexPath)
        
        XCTAssertTrue(presenter.cellSizeFromWasCalled)
    }
    
    func testPresenterConfigureCell() {
        
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as! ProductGridView
        productGridView.view.setNeedsLayout()
        
        let presenter = MockProductGridPresenter()
        let products = [
            Product(productId: "1", title: "", imageUrl: "", priceData: [:])
        ]
        
        productGridView.presenter = presenter
        productGridView.products = products
        
        presenter.view = productGridView
        
        _ = productGridView.collectionView(productGridView.collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(presenter.configureProductCellWasCalled)
        XCTAssertEqual(presenter.configureProductCellIndexPath!.row, 0)
    }
}

private class MockProductGridPresenter: ProductGridPresenterProtocol {
    
    
    var view: ProductGridViewProtocol?
    var interactor: ProductGridInteractorProtocol?
    var router: ProductGridRouterProtocol?
    
    var viewDidLoadWasCalled = false
    var viewDidAppearWasCalled = false
    var didReceiveProductsCalled = false
    var cellSizeFromWasCalled = false
    var configureProductCellWasCalled = false
    var configureProductCellIndexPath: IndexPath?
    
    var productCount: Int {
        return 0
    }
    
    func viewDidLoad() {
        viewDidLoadWasCalled = true
    }
    
    func viewDidAppear() {
        viewDidAppearWasCalled = true
    }
    
    func didReceive(products: [Product]) {
        didReceiveProductsCalled = true
    }
    
    func product(at indexPath: IndexPath) -> Product {
        return Product(productId: "", title: "", imageUrl: "", priceData: [:])
    }
    
    func cellSizeFrom(collectionViewSize: Size, at indexPath: IndexPath) -> Size {
        cellSizeFromWasCalled = true
        return Size(0, 0)
    }
    
    func configure(productGridCell: ProductGridCellProtocol, at indexPath: IndexPath) {
        configureProductCellWasCalled = true
        configureProductCellIndexPath = indexPath
    }
}

private class MockProductGridInteractor: ProductGridInteractorProtocol {
    
    var remoteDataManager: ProductGridRemoteDataProtocol?
    var presenter: ProductGridPresenterProtocol?
    var fetchProductsWasCalled = false
    
    func fetchProducts() {
        fetchProductsWasCalled = true
    }
}

private class MockProductRemoteDataManager: ProductGridRemoteDataProtocol {
    
    var performRequestWasCalled = false
    var requestData: RequestData?
    var remoteDataOutputHandler: ProductGridRemoteDataOutputProtocol?
    
    func performRequest(with requestData: RequestData) {
        performRequestWasCalled = true
        self.requestData = requestData
    }
    
    func performRequest(with requestData: RequestData, networkDataRequest: NetworkDataRequest?) {
        
    }
}

private class MockProductRemoteDataOutput: ProductGridRemoteDataOutputProtocol {
    
    var onProductsReceivedCalled = false
    var products: [Product]?
    
    func onProductsReceived(products: [Product]) {
        onProductsReceivedCalled = true
        self.products = products
    }
    
    func onError() {
        
    }
}

private class MockNetworkDataRequest: NetworkDataRequest {
    
    func checkResponse(callback: @escaping (Any?, Error?) -> Void) {
        
        let products = [
            ["productId": "1", "title": "Product 1", "image": "https://someapi.com/image1.png", "price": ["now": "1"]],
            ["productId": "2", "title": "Product 2", "image": "https://someapi.com/image2.png", "price": ["now": "2"]],
            ["productId": "3", "title": "Product 3", "image": "https://someapi.com/image3.png", "price": ["now": "3"]],
            ["productId": "4", "title": "Product 4", "image": "https://someapi.com/image4.png", "price": ["now": "4"]],
            ["productId": "5", "title": "Product 5", "image": "https://someapi.com/image5.png", "price": ["now": "5"]]
        ]
        
        let mockData = ["products": products]
        
        callback(mockData, nil)
    }
}

private class MockProductGridView: ProductGridViewProtocol {

    var presenter: ProductGridPresenterProtocol?
    
    var reloadDataCalled = false
    var showProductsCalled = false
    
    func show(products: [Product]) {
        showProductsCalled = true
    }
    
    func reloadData() {
        reloadDataCalled = true
    }
}

private class MockProductGridCell: ProductGridCellProtocol {
    
    var configureWasCalled = false
    
    func configure(with product: Product) {
        configureWasCalled = true
    }
}
