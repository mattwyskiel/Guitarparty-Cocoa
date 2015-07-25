//
//  Guitarparty.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc public class Guitarparty {
    
    class var sharedInstance: Guitarparty {
        struct Static {
            static let instance: Guitarparty = Guitarparty()
        }
        return Static.instance
    }
    
    var apiKey: String?
    
    /**
        Set the API key to authenticate API requests.
        
        This is absolutely required to use this API.
    
        - parameter key: The API key to pass to the API.
    */
    public class func setAPIKey(key: String) {
        Guitarparty.sharedInstance.apiKey = key
    }
}
