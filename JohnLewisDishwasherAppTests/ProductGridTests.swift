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
    
    func testPresenterViewWillAppearCalled() {
        
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as? ProductGridView
        let presenter = MockProductGridPresenter()
        
        productGridView?.presenter = presenter
        productGridView?.view.setNeedsLayout()
        productGridView?.viewWillAppear(true)
        
        XCTAssertTrue(presenter.viewWillAppearWasCalled)
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
    
    func testPerformRequestCallbackCalledWithProducts() {
        
        let remoteDataManager = ProductGridRemoteDataManager()
        let mockRemoteDataOutput = MockProductRemoteDataOutput()
        let mockNetworkDataRequest = MockNetworkDataRequest()
        
        remoteDataManager.remoteDataOutputHandler = mockRemoteDataOutput
        
        let parameters: [RequestParameterKey: Any] = [.product : "dishwasher", .pageSize: "20"]
        let requestData = RequestData(endPoint: .products(action: .search), parameters: parameters)
        
        remoteDataManager.fetchProducts(with: requestData, networkDataRequest: mockNetworkDataRequest)
        
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
            Product(productId: "", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "", title: "", priceData: [:], imageUrl: "")
        ]
        
        productGridView.presenter = presenter
        presenter.view = productGridView
        
        productGridView.view.setNeedsLayout()
        presenter.didReceive(products: products)
        
        let productsCount = productGridView.collectionView(productGridView.collectionView!, numberOfItemsInSection: 0)
        XCTAssertEqual(productsCount, products.count)
    }
    
    func testPresenterProductReturn() {
        
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as! ProductGridView
        let presenter = ProductGridPresenter()
        
        productGridView.presenter = presenter
        presenter.view = productGridView
        
        productGridView.view.setNeedsLayout()
        
        let products = [
            Product(productId: "1", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "2", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "3", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "4", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "5", title: "", priceData: [:], imageUrl: "")
        ]
        
        presenter.didReceive(products: products)
        
        let indexPath = IndexPath(row: 2, section: 0)
        let product = productGridView.products[indexPath.row]
        
        XCTAssertEqual(product.productId, products[indexPath.row].productId)
    }
    
    func testCellSizeCalculation() {
        
        // Cell width should be 1/4 of the container width, height 1/2 of the container width (locked to landscape)
        let presenter = ProductGridPresenter()
        
        let collectionViewSize = Size(100, 50)
        
        let cellSize = presenter.cellSizeFrom(collectionViewSize: collectionViewSize)
        
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
            Product(productId: "1", title: "", priceData: [:], imageUrl: "")
        ]
        
        productGridView.presenter = presenter
        productGridView.products = products
        
        presenter.view = productGridView
        
        _ = productGridView.collectionView(productGridView.collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(presenter.configureProductCellWasCalled)
        XCTAssertEqual(presenter.configureProductCellProduct?.productId, products[0].productId)
    }
    
    func testPresenterShowProductDetail() {
        
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as! ProductGridView
        productGridView.view.setNeedsLayout()
        
        let indexPath = IndexPath(row: 1, section: 0)
        
        let products = [
            Product(productId: "1", title: "", priceData: [:], imageUrl: ""),
            Product(productId: "2", title: "", priceData: [:], imageUrl: "")
        ]
        
        let presenter = MockProductGridPresenter()
        productGridView.presenter = presenter
        productGridView.products = products
        productGridView.collectionView(productGridView.collectionView, didSelectItemAt: indexPath)
        
        XCTAssertTrue(presenter.showProductDetailCalled)
        XCTAssertEqual(presenter.showProductDetailProduct?.productId, products[indexPath.row].productId)
    }
    
//    func testRouterPresentProductDetail() {
//
//        let presenter = ProductGridPresenter()
//        let router = MockProductGridRouter()
//        let view = MockProductGridView()
//
//        presenter.router = router
//        presenter.view = view
//
//        let product = Product(productId: "1", title: "", priceData: [:], imageUrl: "")
//
//        presenter.showProductDetail(forProduct: product)
//
//        XCTAssertTrue(router.presentProductDetailScreenWasCalled)
//        XCTAssertEqual(router.presentProductDetailScreenProduct?.productId, product.productId)
//    }
    
    func testPresenterCallsFetchDataForProduct() {
        
        let presenter = ProductGridPresenter()
        let interactor = MockProductGridInteractor()
        
        let product = Product(productId: "1", title: "", priceData: [:], imageUrl: nil)
        
        presenter.interactor = interactor
        presenter.showProductDetail(forProduct: product)
        
        XCTAssertTrue(interactor.fetchProductDataWasCalled)
    }
}

private class MockProductGridPresenter: ProductGridPresenterProtocol {
    
    var view: ProductGridViewProtocol?
    var interactor: ProductGridInteractorProtocol?
    var router: ProductGridRouterProtocol?
    
    var viewDidLoadWasCalled = false
    var viewWillAppearWasCalled = false
    var didReceiveProductsCalled = false
    var cellSizeFromWasCalled = false
    var configureProductCellWasCalled = false
    var configureProductCellProduct: Product?
    var showProductDetailCalled = false
    var showProductDetailProduct: Product?
    
    var productCount: Int {
        return 0
    }
    
    func viewDidLoad() {
        viewDidLoadWasCalled = true
    }
    
    func viewWillAppear() {
        viewWillAppearWasCalled = true
    }
    
    func didReceive(products: [Product]) {
        didReceiveProductsCalled = true
    }
    
    func product(at indexPath: IndexPath) -> Product {
        return Product(productId: "", title: "", priceData: [:], imageUrl: "")
    }
    
    func cellSizeFrom(collectionViewSize: Size) -> Size {
        cellSizeFromWasCalled = true
        return Size(0, 0)
    }
    
    func configure(productGridCell: ProductGridCellProtocol, with product: Product) {
        configureProductCellWasCalled = true
        configureProductCellProduct = product
    }
    
    func showProductDetail(forProduct product: Product) {
        showProductDetailCalled = true
        showProductDetailProduct = product
    }
}

private class MockProductGridInteractor: ProductGridInteractorProtocol {
    
    var remoteDataManager: ProductGridRemoteDataProtocol?
    var presenter: ProductGridPresenterProtocol?
    
    var fetchProductsWasCalled = false
    var fetchProductDataWasCalled = false
    
    func fetchProducts() {
        fetchProductsWasCalled = true
    }
    
    func fetchData(for: Product) {
        fetchProductDataWasCalled = true
    }
}

private class MockProductRemoteDataManager: ProductGridRemoteDataProtocol {
    
    var performRequestWasCalled = false
    var requestData: RequestData?
    var remoteDataOutputHandler: ProductGridRemoteDataOutputProtocol?
    
    func fetchProducts(with requestData: RequestData) {
        performRequestWasCalled = true
        self.requestData = requestData
    }
    
    func fetchProducts(with requestData: RequestData, networkDataRequest: NetworkDataRequest?) {
        
    }
    
    func fetchProductData(with requestData: RequestData) {
        
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

private class MockProductGridRouter: ProductGridRouterProtocol {
    
    var presentProductDetailScreenWasCalled = false
    var presentProductDetailScreenProduct: Product?
    
    static func createProductGridModule() -> UIViewController {
        return UIViewController()
    }
    
    func presentProductDetailScreen(for product: Product, from view: ProductGridViewProtocol) {
        presentProductDetailScreenWasCalled = true
        presentProductDetailScreenProduct = product
    }
}
