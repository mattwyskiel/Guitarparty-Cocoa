//
//  SongList.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/10/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

@objc(GPSongList)
public class SongList: ModelObjectCollection, NSCoding {
    
    required public init(jsonDictionary: [String : AnyObject]) {
        super.init(jsonDictionary: jsonDictionary)
        
        let capturedObjects = objects
        objects = []
        
        for object: [String: AnyObject] in capturedObjects as [[String: AnyObject]] {
            let song = Song(jsonDictionary: object)
            objects.append(song)
        }
    }
    
    override init() {
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        objects = aDecoder.decodeObjectForKey(objectsKey) as [Song]
        
    }
    
    override public func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(objects, forKey: objectsKey)
        
    }
    
}


extension SongList: SequenceType {
    typealias Generator = IndexingGenerator<[Song]>
    
    public func generate() -> IndexingGenerator<[Song]> {
        let songObjects = objects as [Song]
        return songObjects.generate()
    }
}

extension SongList: ArrayLiteralConvertible {
    public class func convertFromArrayLiteral(elements: Song...) -> SongList {
        let songList = SongList(coder: nil)
        songList.objects = elements
        return songList
    }
}
