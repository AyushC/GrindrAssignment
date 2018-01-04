//
//  GRQuestionCollectionViewCell.swift
//  GrindrCodeTest
//
//  Created by Ayush Chamoli on 12/20/17.
//  Copyright © 2017 Envoy. All rights reserved.
//

import UIKit

class GRQuestionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnail: GRImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    func configureCell(questionObject: GRQuestion) {
        if let imageURL = questionObject.ownerProfileURL {
            self.thumbnail.imageFromServerURL(urlString: imageURL, completion: { (success) in
            })
        }
        title.text = questionObject.title
        if let viewers = questionObject.viewers {
            subTitle.text = "\(viewers) views"
        }
    }
}
