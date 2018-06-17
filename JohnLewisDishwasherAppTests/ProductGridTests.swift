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
