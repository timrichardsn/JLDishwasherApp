//
//  ProductDetailProtocols.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

protocol ProductDetailRouterProtocol: class {
    static func createProductDetailModule(for product: Product) -> UIViewController
}

protocol ProductDetailViewProtocol: class {
    var presenter: ProductDetailViewPresenterProtocol? { get set }
    func refresh()
}

protocol ProductDetailViewPresenterProtocol: class {
    var view: ProductDetailViewProtocol? { get set }
    var router: ProductDetailRouterProtocol? { get set }
    var interactor: ProductDetailInteractorProtocol? { get set }
    
    var product: Product? { get set }
    var isLandscape: Bool? { get set }
    var numberOfSections: Int { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRows(inSection section: Int) -> Int
}

protocol ProductDetailInteractorProtocol: class {
    var presenter: ProductDetailViewPresenterProtocol? { get set }
    var remoteDataManager: ProductDetailRemoteDataProtocol? { get set }
    
    func fetchProductData(for product: Product)
}

protocol ProductDetailRemoteDataProtocol: class {
    var remoteDataOutputHandler: ProductDetailRemoteDataOutputProtocol? { get set }
    
    func performRequest(with requestData: RequestData)
}

protocol ProductDetailRemoteDataOutputProtocol: class {
    
    func onProductDataReceived(product: Product)
    func onError()
}
