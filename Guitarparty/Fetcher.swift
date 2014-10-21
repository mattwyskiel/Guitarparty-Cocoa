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
    
        :param: endpoint The endpoint to call to. Remember to start the endpoint with '/v2' and end with a trailing slash ('/')
        :param: method The HTTP request method to use.
        :param: body (optional) An HTTP body dictionary
        :param: completionHandler A block/closure to be called after the request completes.
    */
    class func performRequest(#endpoint: String, method: FetcherRequestMethod, body: [String:AnyObject]? = nil, completionHandler: (jsonDict: [String: AnyObject]?, error: NSError?) -> ()) {
        let urlString = "http://api.guitarparty.com\(endpoint)"
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        urlRequest.HTTPMethod = method.rawValue
        
        if body != nil {
            let bodyData = NSJSONSerialization.dataWithJSONObject(body!, options: NSJSONWritingOptions(0), error: nil)
        }
        
        if Guitarparty.APIConstant.apiKey != nil {
            urlRequest.setValue(Guitarparty.APIConstant.apiKey!, forHTTPHeaderField: "Guitarparty-Api-Key")
        } else {
            fatalError("No API key has been set. The request cannot be completed. \nSet the API Key using Guitarparty.setAPIKey(key: String)")
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let dataTask = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if error != nil {
                let newError = Utils.customError(forNetworkError: error)
                completionHandler(jsonDict: nil, error: newError)
                return
            }
            
            var jsonError: NSError?
            let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonError) as [String:String]
            
            if jsonError != nil {
                completionHandler(jsonDict: nil, error: jsonError)
                return
            }
            
            if jsonDict["error"] != nil {
                let httpResponse = response as NSHTTPURLResponse
                let errorNotError = Utils.customError(forResponse: httpResponse)
                completionHandler(jsonDict: nil, error: errorNotError)
                return
            }
            
            completionHandler(jsonDict: jsonDict, error: nil)
        }
        
    }
    
    class func performRequest(#endpoint: String, method: FetcherRequestMethod, completionHandler: (jsonDict: [String: AnyObject]?, error: NSError?) -> ()) {
        performRequest(endpoint: endpoint, method: method, body: nil) { (jsonDict, error) -> () in
            completionHandler(jsonDict: jsonDict, error: error)
        }
    }
    
}
