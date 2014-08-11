//
//  ModelObjectCollection.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

public class ModelObjectCollection: ModelObject, NSCoding {
    
    public subscript(index: Int) -> AnyObject {
        get {
            return objects[index]
    }
        set(newValue) {
            objects[index] = newValue
    }
    }
    
    /** 
        Array of objects of a subtype of ModelObject
    */
    public var objects: [AnyObject]
    let objectsKey = "objects"
    
    required public init(jsonDictionary: [String : AnyObject]) {
        let objectsArrayAnyObject: AnyObject? = jsonDictionary[objectsKey]
        objects = objectsArrayAnyObject as [AnyObject]
        
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder!) {
        objects = aDecoder.decodeObjectForKey(objectsKey) as [AnyObject]
        super.init(coder: aDecoder)
    }
   
    override public func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(objects, forKey: objectsKey)
    }
    
    override init() {
        objects = []
        super.init()
    }
    
}

extension ModelObjectCollection: SequenceType {
    public func generate() -> IndexingGenerator<[AnyObject]> {
        return objects.generate()
    }
}
