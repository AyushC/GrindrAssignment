//
//  YHImageView.swift
//  YHNewsReader
//
//  Created by Ayush Chamoli on 12/7/17.
//  Copyright © 2017 Ayush Chamoli. All rights reserved.
//

import UIKit

class GRImageView: UIImageView {
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureConstraints()
    }
    
    private func configureConstraints() {
        self.addSubview(activityView)
        self.activityView.hidesWhenStopped = true
        self.activityView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[activityView(50)]",
                                                           options: NSLayoutFormatOptions.alignAllCenterX,
                                                           metrics: nil,
                                                           views: ["superview":self, "activityView":activityView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[superview]-(<=1)-[activityView(50)]",
                                                           options: NSLayoutFormatOptions.alignAllCenterY,
                                                           metrics: nil,
                                                           views: ["superview":self, "activityView":activityView]))
    }
    
}
