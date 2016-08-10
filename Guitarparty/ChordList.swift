//
//  ChordList.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/25/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

public final class ChordList : ModelObjectCollection {
    
    public var objects: [Chord] = []
    let objectsKey = "objects"
    
    required public init(json jsonDictionary: [String : AnyObject]) {
        let objectsArrayAnyObject: AnyObject? = jsonDictionary[objectsKey]
        let objectDictsArray = objectsArrayAnyObject as! [[String: AnyObject]]
        for chordObject in objectDictsArray {
            let chord = Chord(json: chordObject)
            objects.append(chord)
        }
    }
    
    required public init(objects: [Chord]) {
        self.objects = objects
    }
    
    required public init?(coder aDecoder: NSCoder) {
        objects = aDecoder.decodeObject(forKey: objectsKey) as! [Chord]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(objects, forKey: objectsKey)
    }
}
