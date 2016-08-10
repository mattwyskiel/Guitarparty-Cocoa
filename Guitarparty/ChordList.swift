//
//  ChordList.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/25/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPChordList)
public final class ChordList : ModelObjectCollection {
    
    public var objects: [Chord] = []
    let objectsKey = "objects"
    
    required public init(jsonDictionary: [String : AnyObject]) {
        let objectsArrayAnyObject: AnyObject? = jsonDictionary[objectsKey]
        let objectDictsArray = objectsArrayAnyObject as! [[String: AnyObject]]
        for chordObject in objectDictsArray {
            let chord = Chord(jsonDictionary: chordObject)
            objects.append(chord)
        }
    }
    
    required public init(objects: [Chord]) {
        self.objects = objects
    }
    
    required public init?(coder aDecoder: NSCoder) {
        objects = aDecoder.decodeObjectForKey(objectsKey) as! [Chord]
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objects, forKey: objectsKey)
    }
}
