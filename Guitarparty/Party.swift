//
//  Party.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/16/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import UIKit

public class Party: ModelObject {
    
    public var currentSongId: Int?
    public var description: String?
    public var url: NSURL
    public var shortCode: String
    public var songCount: Int
    public var title: String
    public var uri: String
    
    let currentSongKey = "current_song"
    let descriptionKey = "description"
    let urlKey = "human_uri"
    let shortCodeKey = "short_code"
    let songCountKey = "song_count"
    let titleKey = "title"
    let uriKey = "uri"
    
    public required init(jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        currentSongId = jsonNSDict.objectForKey(currentSongKey) as Int?
        description = jsonNSDict.objectForKey(descriptionKey) as String?
        
        let urlString = jsonNSDict.objectForKey(urlKey) as String
        url = NSURL(string: urlString)
        
        shortCode = jsonNSDict.objectForKey(shortCodeKey) as String
        songCount = jsonNSDict.objectForKey(songCountKey) as Int
        title = jsonNSDict.objectForKey(titleKey) as String
        uri = jsonNSDict.objectForKey(uriKey) as String
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        if currentSongId != nil {
            aCoder.encodeObject(currentSongId!, forKey: currentSongKey)
        }
        if description != nil {
            aCoder.encodeObject(description!, forKey: descriptionKey)
        }
        
        aCoder.encodeObject(url, forKey: urlKey)
        aCoder.encodeObject(shortCode, forKey: shortCodeKey)
        aCoder.encodeObject(songCount, forKey: songCountKey)
        aCoder.encodeObject(title, forKey: titleKey)
        aCoder.encodeObject(uri, forKey: uriKey)
    }
    
    public required init(coder aDecoder: NSCoder) {
        currentSongId = aDecoder.decodeObjectForKey(currentSongKey) as Int?
        description = aDecoder.decodeObjectForKey(descriptionKey) as String?
        url = aDecoder.decodeObjectForKey(urlKey) as NSURL
        shortCode = aDecoder.decodeObjectForKey(shortCodeKey) as String
        songCount = aDecoder.decodeObjectForKey(songCountKey) as Int
        title = aDecoder.decodeObjectForKey(titleKey) as String
        uri = aDecoder.decodeObjectForKey(uriKey) as String
    }
}
