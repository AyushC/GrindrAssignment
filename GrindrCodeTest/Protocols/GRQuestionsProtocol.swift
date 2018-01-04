//
//  File.swift
//  YHNewsReader
//
//  Created by Ayush Chamoli on 12/7/17.
//  Copyright © 2017 Ayush Chamoli. All rights reserved.
//

import Foundation

typealias GameCompletionBlock =  (_ result:  [GRQuestion]?, _ error: Error?) -> Void

protocol GRQuestionsProtocol {
    func fetchQuestions(_ completion: @escaping GameCompletionBlock)
}

extension GRQuestionsProtocol {
    
    func fetchQuestions(_ completion: @escaping GameCompletionBlock) {
        GRNetworking.requestQuestions { (result, error) in
            guard let response = result,
            let arrQuestions = response["items"] as? [[String: AnyObject]] else {
                completion(nil, error)
                    return
            }
            var questions = [GRQuestion]()
            for questionDict in arrQuestions {
                let question = GRQuestion(dictData: questionDict)
                questions.append(question)
            }
            completion(questions, error)
        }
    }
    
}
