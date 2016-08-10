//
//  Party.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/16/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

public class Party: ModelObject {
    
    public var currentSongId: Int?
    public var description: String?
    public var url: URL
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
    
    public required init(json jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        currentSongId = jsonNSDict.object(forKey: currentSongKey) as! Int?
        description = jsonNSDict.object(forKey: descriptionKey) as! String?
        
        let urlString = jsonNSDict.object(forKey: urlKey) as! String
        url = URL(string: urlString)!
        
        shortCode = jsonNSDict.object(forKey: shortCodeKey) as! String
        songCount = jsonNSDict.object(forKey: songCountKey) as! Int
        title = jsonNSDict.object(forKey: titleKey) as! String
        uri = jsonNSDict.object(forKey: uriKey) as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        if currentSongId != nil {
            aCoder.encode(currentSongId!, forKey: currentSongKey)
        }
        if description != nil {
            aCoder.encode(description!, forKey: descriptionKey)
        }
        
        aCoder.encode(url, forKey: urlKey)
        aCoder.encode(shortCode, forKey: shortCodeKey)
        aCoder.encode(songCount, forKey: songCountKey)
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(uri, forKey: uriKey)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        currentSongId = aDecoder.decodeObject(forKey: currentSongKey) as! Int?
        description = aDecoder.decodeObject(forKey: descriptionKey) as! String?
        url = aDecoder.decodeObject(forKey: urlKey) as! URL
        shortCode = aDecoder.decodeObject(forKey: shortCodeKey) as! String
        songCount = aDecoder.decodeObject(forKey: songCountKey) as! Int
        title = aDecoder.decodeObject(forKey: titleKey) as! String
        uri = aDecoder.decodeObject(forKey: uriKey) as! String
    }
}
