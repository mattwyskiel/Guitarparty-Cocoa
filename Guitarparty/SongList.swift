//
//  SongList.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/10/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPSongList)
public final class SongList: ModelObjectCollection, ArrayLiteralConvertible {
    
    public subscript(index: Int) -> Song {
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
    public var objects: [Song] = []
    typealias Element = Song
    
    let objectsKey = "objects"
    
    public required init(jsonDictionary: [String : AnyObject]) {
        let objectsArrayAnyObject: AnyObject? = jsonDictionary[objectsKey]
        let objectDictsArray = objectsArrayAnyObject as [[String: AnyObject]]
        for songObject in objectDictsArray {
            let song = Song(jsonDictionary: songObject)
            objects.append(song)
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        objects = aDecoder.decodeObjectForKey(objectsKey) as [Song]
    }
   
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objects, forKey: objectsKey)
    }
    
    init() {

    }
    
    public init(arrayLiteral elements: Song...) {
        objects = elements
    }
    
}

extension SongList: SequenceType {
    public func generate() -> IndexingGenerator<[Song]> {
        return objects.generate()
    }
}
