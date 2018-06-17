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
    }
    
    func testPresenterViewDidLoadCalled() {
        
        let productGridView = ProductGridRouter.createProductGridModule().childViewControllers.first as? ProductGridView
        let presenter = MockProductGridPresenter()
        
        productGridView?.presenter = presenter
        
        productGridView?.view.setNeedsLayout()
        
        XCTAssertTrue(presenter.viewDidLoadWasCalled)
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
    
    func testPerformRequestCallbackCalled() {
        
        let remoteDataManager = ProductGridRemoteDataManager()
        let mockRemoteDataOutput = MockProductRemoteDataOutput()
        let mockNetworkDataRequest = MockNetworkDataRequest()
        
        remoteDataManager.remoteDataOutputHandler = mockRemoteDataOutput
        
        let parameters: [RequestParameterKey: Any] = [.product : "dishwasher", .pageSize: "20"]
        let requestData = RequestData(endPoint: .products(action: .search), parameters: parameters)
        
        remoteDataManager.performRequest(with: requestData, networkDataRequest: mockNetworkDataRequest)
        
        XCTAssertTrue(mockRemoteDataOutput.onProductsReceivedCalled)
    }
}

private class MockProductGridPresenter: ProductGridPresenterProtocol {
    
    var view: ProductGridViewProtocol?
    var interactor: ProductGridInteractorProtocol?
    var router: ProductGridRouterProtocol?
    
    var viewDidLoadWasCalled = false
    
    func viewDidLoad() {
        viewDidLoadWasCalled = true
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
    
    func onProductsReceived() {
        onProductsReceivedCalled = true
    }
    
    func onError() {
        
    }
}

private class MockNetworkDataRequest: NetworkDataRequest {
    
    func checkResponse(callback: @escaping (Any?, Error?) -> Void) {
        callback("success", nil)
    }
}
