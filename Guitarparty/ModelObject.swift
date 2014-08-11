//
//  ModelObject.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

@objc(GPModelObject)
public class ModelObject: NSCoding {
   
    
    required public init(jsonDictionary: [String:AnyObject]) {
        fatalError("This class does not override and implement init(jsonDictionary:)")
    }
    
    init() {
        // Nothing to initialize
    }
    
    required public init(coder aDecoder: NSCoder!) {
        // No objects to decode
    }
    
    public func encodeWithCoder(aCoder: NSCoder!) {
        // No objects to encode
    }
    
}
