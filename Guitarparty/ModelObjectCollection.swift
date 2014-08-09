//
//  ModelObjectCollection.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

class ModelObjectCollection: ModelObject, NSCoding {
    
    var objects: [AnyObject]?
    let objectsKey = "objects"
    
    required init(jsonDictionary: [String : AnyObject]) {
        if let objectsArray: AnyObject = jsonDictionary[objectsKey] {
            objects = objectsArray as? [AnyObject]
        }
        super.init()
    }
    
    required init(coder aDecoder: NSCoder!) {
        objects = aDecoder.decodeObjectForKey(objectsKey) as? [AnyObject]
        super.init(coder: aDecoder)
    }
   
    override func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(objects, forKey: objectsKey)
    }
}
