//
//  ProductDetailPresenter.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

class ProductDetailPresenter: ProductDetailViewPresenterProtocol {
    
    weak var view: ProductDetailViewProtocol?
    var router: ProductDetailRouterProtocol?
    var product: Product?
    var isLandscape: Bool?
    
    func viewDidLoad() {
        view?.refresh()
    }
    
    func viewWillAppear() {
        OrientationLocker.lockOrientation(.all)
    }
}
