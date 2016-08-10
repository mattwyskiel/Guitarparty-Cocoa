//
//  Fetcher.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

public class Fetcher {
    
    enum FetcherRequestMethod: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    /**
        Makes an internet request to the Guitarparty API
    
        - parameter endpoint: The endpoint to call to. Remember to start the endpoint with '/v2' and end with a trailing slash ('/')
        - parameter method: The HTTP request method to use.
        - parameter body: (optional) An HTTP body dictionary
        - parameter completionHandler: A block/closure to be called after the request completes.
    */
    class func performRequest(endpoint: String, method: FetcherRequestMethod, body: [String:AnyObject]? = nil, completionHandler: (jsonDict: [String: AnyObject]?, error: Error?) -> ()) {
        let urlString = "http://api.guitarparty.com\(endpoint)"
        var urlRequest = URLRequest(url: URL(string: urlString)!)
        urlRequest.httpMethod = method.rawValue
        
        
        if body != nil {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body!, options: JSONSerialization.WritingOptions(rawValue: 0))
            } catch _ {
                
            }
        }
        
        if let apiKey = Guitarparty.sharedInstance.apiKey {
            urlRequest.setValue(apiKey, forHTTPHeaderField: "Guitarparty-Api-Key")
        } else {
            fatalError("No API key has been set. The request cannot be completed. \nSet the API Key using Guitarparty.setAPIKey(key: String)")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                let newError = Utils.customError(forNetworkError: error!)
                completionHandler(jsonDict: nil, error: newError)
                return
            }
            
            var jsonDict: [String: String]
            do {
                jsonDict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String:String]
            } catch {
                completionHandler(jsonDict: nil, error: error)
                return
            }
            
            if jsonDict["error"] != nil {
                let httpResponse = response as! HTTPURLResponse
                let errorNotError = Utils.customError(for: httpResponse)
                completionHandler(jsonDict: nil, error: errorNotError)
                return
            }
            
            completionHandler(jsonDict: jsonDict, error: nil)
        }.resume()
        
    }
    
}
