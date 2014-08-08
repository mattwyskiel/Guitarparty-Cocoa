//
//  Guitarparty.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

@objc public class Guitarparty {
    
    struct APIConstant {
        static var apiKey: String?
    }
    
    /**
        Set the API key to authenticate API requests.
        
        This is absolutely required to use this API.
    
        :param: key The API key to pass to the API.
    */
    public class func setAPIKey(key: String) {
        APIConstant.apiKey = key
    }
}
