//
//  ModelObjectCollection.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

class ModelObjectCollection: ModelObject {
    
    var objects: [AnyObject]?
    
    override init(jsonDictionary: [String : AnyObject]) {
        if let objectsArray: AnyObject = jsonDictionary["Objects"] {
            objects = objectsArray as? [AnyObject]
        }
        super.init()
    }
   
}
