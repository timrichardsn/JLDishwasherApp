//
//  ProductDetailView.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

class ProductDetailView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specialOffer: UILabel!
    @IBOutlet weak var guarantee: UILabel!
    
    var presenter: ProductDetailViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        
        presenter?.isLandscape = UIDevice.current.orientation.isLandscape
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        presenter?.isLandscape = UIDevice.current.orientation.isLandscape
    }
    
    override var traitCollection: UITraitCollection {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            if UIDevice.current.orientation.isPortrait {
                return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
            } else if UIDevice.current.orientation.isLandscape {
                return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
            }
        }
        
        return super.traitCollection
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

extension ProductDetailView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let imagesCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ProductScrollableImagesCell
                
                if let imageUrls = presenter?.product?.urls {
                    imagesCell.configure(with: imageUrls)
                }
                
                return imagesCell
            } else if indexPath.row == 1 {
                return tableView.dequeueReusableCell(withIdentifier: "priceDataCell", for: indexPath)
            }
            
        } else if indexPath.section == 1 {
            let productInformation = tableView.dequeueReusableCell(withIdentifier: "productInformation", for: indexPath) as! ProductInformationCell
            
            if let product = presenter?.product {
                productInformation.configure(product: product)
            }
            
            return productInformation
        } else if indexPath.section == 2 {
            let featureCell = tableView.dequeueReusableCell(withIdentifier: "featureCell", for: indexPath) as! ProductFeatureCell
            
            let data = presenter?.product?.displayPropertiesForAttribute(atIndex: indexPath.row) ?? (name: nil, value: nil)
            featureCell.configure(name: data.name, value: data.value)
            
            return featureCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let cellHeight = presenter?.heightForCellAt(row: indexPath.row, section: indexPath.section) {
            return CGFloat(cellHeight)
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.titleForHeaderIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if let sectionHeight = presenter?.heightForHeaderIn(section: section) {
            return CGFloat(sectionHeight)
        }
        
        return .leastNonzeroMagnitude
    }
}

extension ProductDetailView: ProductDetailViewProtocol {
    
    func refresh() {
        
        priceLabel.text = presenter?.product?.priceString ?? ""
        specialOffer.text = presenter?.product?.displaySpecialOffer ?? ""
        guarantee.text = presenter?.product?.guaranteeInformation?.first ?? ""
        
        tableView.reloadData()
    }
}
