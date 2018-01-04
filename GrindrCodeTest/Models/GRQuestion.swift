//
//  YHArticle.swift
//  YHNewsReader
//
//  Created by Ayush Chamoli on 12/7/17.
//  Copyright © 2017 Ayush Chamoli. All rights reserved.
//

import Foundation

class GRQuestion {
    
    var ownerName: String?
    var ownerProfileURL: String?
    var link: String?
    var id: Int?
    var viewers: Int?
    var title: String?
    
    init(dictData: [String: AnyObject]) {
        if let owner = dictData["owner"] as? [String: Any] {
            self.ownerName = owner["display_name"] as? String
            self.ownerProfileURL = owner["profile_image"] as? String
        }
        self.link = dictData["link"] as? String
        self.id = dictData["question_id"] as? Int
        self.viewers = dictData["view_count"] as? Int
        self.title = dictData["title"] as? String
    }
    
}
