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
}

protocol ProductDetailViewPresenterProtocol {
    var view: ProductDetailViewProtocol? { get set }
    var router: ProductDetailRouterProtocol? { get set }
    var product: Product? { get set }
}
