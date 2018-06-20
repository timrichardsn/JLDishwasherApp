//
//  ProductGridProtocols.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

typealias Size = (width: Float, height: Float)

protocol ProductGridRouterProtocol: class {
    static func createProductGridModule() -> UIViewController
    func presentProductDetailScreen(for product: Product, from view: ProductGridViewProtocol)
}

protocol ProductGridViewProtocol: class {
    var presenter: ProductGridPresenterProtocol? { get set }
    
    func show(products: [Product])
}

protocol ProductGridPresenterProtocol: class {
    
    var view: ProductGridViewProtocol? { get set }
    var interactor: ProductGridInteractorProtocol? { get set }
    var router: ProductGridRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func didReceive(products: [Product])
    func cellSizeFrom(collectionViewSize: Size) -> Size
    func configure(productGridCell: ProductGridCellProtocol, with product: Product)
    func showProductDetail(forProduct product: Product)
}

protocol ProductGridInteractorProtocol: class {
    var presenter: ProductGridPresenterProtocol? { get set }
    var remoteDataManager: ProductGridRemoteDataProtocol? { get set }
    
    func fetchProducts()
    func fetchData(for: Product)
}

protocol ProductGridRemoteDataProtocol: class {
    
    var remoteDataOutputHandler: ProductGridRemoteDataOutputProtocol? { get set }
    
    func fetchProducts(with requestData: RequestData)
    func fetchProductData(with requestData: RequestData)
    func fetchProducts(with requestData: RequestData, networkDataRequest: NetworkDataRequest?)
}

protocol ProductGridRemoteDataOutputProtocol: class {
    
    func onProductsReceived(products: [Product])
    func onError()
}

protocol ProductGridCellProtocol: class {
    func configure(with product: Product)
}
