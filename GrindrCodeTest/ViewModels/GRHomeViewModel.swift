//
//  YHNewsViewModel.swift
//  YHNewsReader
//
//  Created by Ayush Chamoli on 12/7/17.
//  Copyright © 2017 Ayush Chamoli. All rights reserved.
//

import UIKit

typealias CompletionHandler =  (_ success: Bool, _ error: Error?) -> Void

class GRHomeViewModel: GRQuestionsProtocol {
    var questions = [GRQuestion]()
    
    func requestQuestions(completion: @escaping CompletionHandler) {
        self.fetchQuestions { (questions, error) in
            guard let arrQuestions = questions else {
                completion(false, error)
                return
            }
            self.questions = arrQuestions
            completion(true, error)
        }
    }
        
}
