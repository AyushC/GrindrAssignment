//
//  UIImageView++.swift
//  YHNewsReader
//
//  Created by Ayush Chamoli on 12/7/17.
//  Copyright © 2017 Ayush Chamoli. All rights reserved.
//

import Foundation
import UIKit

extension GRImageView {
    public func imageFromServerURL(urlString: String, completion: @escaping (_ success: Bool) -> Void) {
        self.activityView.startAnimating()
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { [weak self] (data, response, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                self?.activityView.stopAnimating()
                if error != nil {
                    completion(false)
                    return
                }
                let image = UIImage(data: data!)
                self?.image = image
                completion(true)
            })
            
        }).resume()
    }
}
