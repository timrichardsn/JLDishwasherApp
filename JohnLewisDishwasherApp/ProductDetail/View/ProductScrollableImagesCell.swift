//
//  ProductScrollableImagesCell.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 20/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductScrollableImagesCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    private var imageViews = [UIImageView]()
    
    func configure(with urls: [String]) {
        
        imageViews.forEach {
            $0.af_cancelImageRequest()
            $0.removeFromSuperview()
        }
        imageViews = [UIImageView]()
        
        let scrollViewSize = contentView.bounds
        
        scrollView.contentSize = CGSize(width: CGFloat(urls.count) * scrollViewSize.width,
                                        height: scrollViewSize.height)
        
        for i in 0..<urls.count {
            
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * scrollViewSize.width,
                                                      y: 0,
                                                      width: scrollViewSize.width,
                                                      height: scrollViewSize.height))
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
            
            if let url = URL(string: "https:\(urls[i])") {
                imageView.af_setImage(withURL: url)
            }
        }
    }
}
