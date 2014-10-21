//
//  ArtistList.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/12/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPArtistList)
public final class ArtistList: ModelObjectCollection, ArrayLiteralConvertible {

    public var objects: [Artist] = []
    let objectsKey = "objects"

    required public init(jsonDictionary: [String : AnyObject]) {
        let objectsArrayAnyObject: AnyObject? = jsonDictionary[objectsKey]
        let objectDictsArray = objectsArrayAnyObject as [[String: AnyObject]]
        for songObject in objectDictsArray {
            let artist = Artist(jsonDictionary: songObject)
            objects.append(artist)
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        objects = aDecoder.decodeObjectForKey(objectsKey) as [Artist]
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objects, forKey: objectsKey)
    }

    init() {
        objects = []
    }
    
    public init(arrayLiteral elements: Artist...) {
        objects = elements;
    }
}

extension ArtistList: SequenceType {
    typealias Generator = IndexingGenerator<[Artist]>
    
    public func generate() -> IndexingGenerator<[Artist]> {
        let artistObjects = objects as [Artist]
        return artistObjects.generate()
    }
}
