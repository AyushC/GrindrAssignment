//
//  FTNetworking.swift
//  FuboTvSample
//
//  Created by Ayush Chamoli on 9/1/17.
//  Copyright © 2017 Ayush Chamoli. All rights reserved.
//

import UIKit

typealias CompletionBlock =  (_ result:  [String: AnyObject]?, _ error: Error?) -> Void

let EV_ROOT_URL = "https://api.stackexchange.com"

// MARK: - EndPoint URLs
internal enum EndPointURL: String {
    case Questions   = "/2.2/questions"
}

internal enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

class GRNetworking {
    
    class func requestQuestions(_ compBlock: @escaping CompletionBlock) {
        let params: Dictionary<String, String> = ["order": "desc",
                                                  "sort": "activity",
                                                  "site": "stackoverflow"]
        requestWithURL(rootURL: EV_ROOT_URL, endPointURL: EndPointURL.Questions.rawValue, parameters: params as Dictionary<String, AnyObject>, method: HTTPMethod.GET, jsonObject: nil, andCompletionBlock: compBlock)
    }
    
    internal class func requestWithURL(rootURL:String, endPointURL: String?, parameters: Dictionary<String, AnyObject>?, method: HTTPMethod, jsonObject:AnyObject?, andCompletionBlock compBlock: @escaping CompletionBlock) {
        
        var urlString = rootURL
        if endPointURL != nil {
            urlString = urlString + endPointURL!
        }
        if parameters != nil {
            urlString = urlString + "?" + self.convertToUrlParameter(dict: parameters)
        }
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: NSURL(string: urlString)! as URL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 60
        request.httpMethod = method.rawValue
        
        print("=============================CALLING API=============================")
        print(urlString)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode != 400 else {
                    if let responseDict = getJSONDict(fromData: data),
                    let errorCode = responseDict["error_id"] as? Int,
                    let errorMessage = responseDict["error_message"] as? String {
                        let serverNSError = NSError(domain:"", code:errorCode, userInfo:[NSLocalizedDescriptionKey : errorMessage])
                        compBlock(nil, serverNSError)
                    }
                    return
                }
                guard httpResponse.statusCode != 500 else {
                    compBlock(nil, error)
                    return
                }
                guard httpResponse.statusCode == 200 else {
                    compBlock(nil, error)
                    return
                }
                
                if let responseDict = getJSONDict(fromData: data) {
                    compBlock(responseDict, nil)
                }
                
                compBlock(nil, error)
                return
            }
        }
        dataTask.resume()
    }
    
    private class func getJSONDict(fromData input: Data?) -> [String: AnyObject]? {
        if let data = input {
            guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else {
                return nil
            }
            return jsonDict
        }
        return nil
    }
    
    class func convertToUrlParameter(dict: [String : AnyObject]?) -> String {
        var parameterString = ""
        var i: Int = 0
        if let dict = dict {
            for (key, value) in dict {
                if i > 0 && i < dict.count {
                    parameterString = parameterString.appendingFormat("&")
                }
                parameterString = parameterString.appendingFormat("\(key)=\(value)")
                i += 1
            }
        }
        return parameterString
    }
    
    class func jsonFromString(data: AnyObject) -> String? {
        guard let jsonData: Data = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return nil
        }
        let jsonString: String? = String(data: jsonData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        return jsonString
    }

}
