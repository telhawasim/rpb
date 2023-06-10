//
//  UIImageView.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    @discardableResult func isCircularImage() -> CGFloat {
        self.layer.cornerRadius = self.frame.height / 2
        return self.layer.cornerRadius
    }
    
    func setImageURLElsePlaceHolder(url: String?, placeholder: UIImage?, completion: (() -> Void)? = nil ) {
        if url == "poc.synavos.com/uploads/undefined" {
            self.image = placeholder
            return
        }
        if let profileImage = url, !profileImage.isEmpty {
            self.setImage(url: profileImage, completion: completion)
        } else {
            self.image = placeholder
        }
    }
    
    func setImage(url: String, completion: (() -> Void)? = nil) {
        
        if url.isEmpty {
            return
        }
        
        let activityInd = UIActivityIndicatorView()
        activityInd.color = UIColor.black
        self.addSubview(activityInd)
        activityInd.translatesAutoresizingMaskIntoConstraints = false
        activityInd.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityInd.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        activityInd.startAnimating()
        
        if let urlStr = URL.init(string: url) {
            let resource = ImageResource(downloadURL: urlStr)
            
            KingfisherManager.shared.retrieveImage(with: resource, options: [.cacheOriginalImage], progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    activityInd.stopAnimating()
                    self.image = value.image
                    completion?()
                    
                case .failure(let error):
                    activityInd.stopAnimating()
                    
                    print(urlStr)
                    print("Error: \(error)")
                }
            }
        }
        
    }
    
    func imageToUrlResult(image : UIImageView, url: String) -> Bool  {
        image.kf.indicatorType = .activity
        var isResult =  false
        
        if let urlStr = URL.init(string:url)
        {
            //            image.kf.setImage(with: urlStr)
            let resource = ImageResource(downloadURL: urlStr)
            
            KingfisherManager.shared.retrieveImage(with: resource, options:   [.forceRefresh], progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    isResult =  true
                    image.image =  value.image
                    print("Image: (value.image). Got from: (value.cacheType)")
                    
                    
                case .failure(let error):
                    isResult = false
                    print(urlStr)
                    print("Error: (error)")
                }
                
            }
            
            return  isResult
            
            
            //
        }
        return  isResult
        
    }
}
