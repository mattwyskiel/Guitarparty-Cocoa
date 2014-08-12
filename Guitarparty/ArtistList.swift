//
//  ArtistList.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/12/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

@objc(GPArtistList)
public class ArtistList: ModelObjectCollection {
    required public init(jsonDictionary: [String : AnyObject]) {
        super.init(jsonDictionary: jsonDictionary)
        
        let capturedObjects = objects
        objects = []
        
        for object: [String: AnyObject] in capturedObjects as [[String: AnyObject]] {
            let artist = Artist(jsonDictionary: object)
            objects.append(artist)
        }
    }
    
    required public init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        objects = aDecoder.decodeObjectForKey(objectsKey) as [Artist]
    }
    
    override public func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(objects, forKey: objectsKey)
    }
    
    override init() {
        super.init()
    }
}

extension ArtistList: SequenceType {
    typealias Generator = IndexingGenerator<[Artist]>
    
    public func generate() -> IndexingGenerator<[Artist]> {
        let artistObjects = objects as [Artist]
        return artistObjects.generate()
    }
}

extension ArtistList: ArrayLiteralConvertible {
    public class func convertFromArrayLiteral(elements: Artist...) -> ArtistList {
        let artistList = ArtistList()
        artistList.objects = elements
        return artistList
    }
}
