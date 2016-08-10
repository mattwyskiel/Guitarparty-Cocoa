//
//  SongList.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/10/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

public final class SongList: ModelObjectCollection {
    
    /**
        Array of objects of a subtype of ModelObject
    */
    public var objects: [Song] = []
    
    public required init(objects: [Song]) {
        self.objects = objects
    }
    
    let objectsKey = "objects"
    
    public required init(json: [String : AnyObject]) {
        let objectsArrayAnyObject: AnyObject? = json[objectsKey]
        let objectDictsArray = objectsArrayAnyObject as! [[String: AnyObject]]
        for songObject in objectDictsArray {
            let song = Song(json: songObject)
            objects.append(song)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        objects = aDecoder.decodeObject(forKey: objectsKey) as! [Song]
    }
   
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(objects, forKey: objectsKey)
    }
    
}
