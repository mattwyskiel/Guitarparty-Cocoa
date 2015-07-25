//
//  Fetcher.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPFetcher)
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
    class func performRequest(endpoint endpoint: String, method: FetcherRequestMethod, body: [String:AnyObject]? = nil, completionHandler: (jsonDict: [String: AnyObject]?, error: ErrorType?) -> ()) {
        let urlString = "http://api.guitarparty.com\(endpoint)"
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        urlRequest.HTTPMethod = method.rawValue
        
        
        if body != nil {
            do {
                urlRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body!, options: NSJSONWritingOptions(rawValue: 0))
            } catch _ {
                
            }
        }
        
        if let apiKey = Guitarparty.sharedInstance.apiKey {
            urlRequest.setValue(apiKey, forHTTPHeaderField: "Guitarparty-Api-Key")
        } else {
            fatalError("No API key has been set. The request cannot be completed. \nSet the API Key using Guitarparty.setAPIKey(key: String)")
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        _ = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if error != nil {
                let newError = Utils.customError(forNetworkError: error!)
                completionHandler(jsonDict: nil, error: newError)
                return
            }
            
            var jsonDict: [String: String]
            do {
                jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [String:String]
            } catch {
                completionHandler(jsonDict: nil, error: error)
                return
            }
            
            if jsonDict["error"] != nil {
                let httpResponse = response as! NSHTTPURLResponse
                let errorNotError = Utils.customError(forResponse: httpResponse)
                completionHandler(jsonDict: nil, error: errorNotError)
                return
            }
            
            completionHandler(jsonDict: jsonDict, error: nil)
        }
        
    }
    
}
