//
//  Song.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

@objc(GPSong)
public class Song: ModelObject, NSCoding {
    
    public var authors: [Author]
    public var body: String
    public var htmlBody: String
    public var strippedBody: String
    public var chords: [Chord]
    @objc(identifier) public var id: Int
    public var permalink: NSURL
    public var tags: [String]
    public var title: String
    public var uri: String
    
    let authorsKey = "authors"
    let bodyKey = "body"
    let htmlBodyKey = "body_chords_html"
    let strippedBodyKey = "body_stripped"
    let chordsKey = "chords"
    let idKey = "id"
    let permalinkKey = "permalink"
    let tagsKey = "tags"
    let titleKey = "title"
    let uriKey = "uri"
    
    required public init(coder aDecoder: NSCoder!) {
        authors = aDecoder.decodeObjectForKey(authorsKey) as [Author]
        body = aDecoder.decodeObjectForKey(bodyKey) as String
        htmlBody = aDecoder.decodeObjectForKey(htmlBodyKey) as String
        strippedBody = aDecoder.decodeObjectForKey(strippedBodyKey) as String
        chords = aDecoder.decodeObjectForKey(chordsKey) as [Chord]
        id = aDecoder.decodeObjectForKey(idKey) as Int
        permalink = aDecoder.decodeObjectForKey(permalinkKey) as NSURL
        tags = aDecoder.decodeObjectForKey(tagsKey) as [String]
        title = aDecoder.decodeObjectForKey(titleKey) as String
        uri = aDecoder.decodeObjectForKey(uriKey) as String
        
        super.init(coder: aDecoder)
    }
    
    required public init(jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        // Get author array set up
        authors = []
        let authorDictArray = jsonNSDict.objectForKey(authorsKey) as Array<[String: AnyObject]>
        for authorDict in authorDictArray {
            let author = Author(jsonDictionary: authorDict)
            authors.append(author)
        }
        
        body = jsonNSDict.objectForKey(bodyKey) as String
        htmlBody = jsonNSDict.objectForKey(htmlBodyKey) as String
        strippedBody = jsonNSDict.objectForKey(strippedBodyKey) as String
        
        // Get chord array set up
        chords = []
        let chordDictArray = jsonNSDict.objectForKey(authorsKey) as Array<[String: AnyObject]>
        for chordDict in authorDictArray {
            let chord = Chord(jsonDictionary: chordDict)
            chords.append(chord)
        }
        
        id = jsonNSDict.objectForKey(idKey) as Int
        permalink = NSURL(string: jsonNSDict.objectForKey(permalinkKey) as String)
        tags = jsonNSDict.objectForKey(tagsKey) as [String]
        title = jsonNSDict.objectForKey(titleKey) as String
        uri = jsonNSDict.objectForKey(uriKey) as String
        
        super.init()
    }
    
    override public func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(authors, forKey: authorsKey)
        aCoder.encodeObject(body, forKey: bodyKey)
        aCoder.encodeObject(htmlBody, forKey: htmlBodyKey)
        aCoder.encodeObject(strippedBody, forKey: strippedBodyKey)
        aCoder.encodeObject(chords, forKey: chordsKey)
        aCoder.encodeObject(id, forKey: idKey)
        aCoder.encodeObject(permalink, forKey: permalinkKey)
        aCoder.encodeObject(tags, forKey: tagsKey)
        aCoder.encodeObject(title, forKey: titleKey)
        aCoder.encodeObject(uri, forKey: uriKey)
    }
    
    @objc(GPSongAuthor)
    public class Author: ModelObject, NSCoding {
        
        public var name: String
        public var types: [String]
        public var uri: String
        
        let nameKey = "name"
        let typesKey = "types"
        let uriKey = "uri"
        
        required public init(coder aDecoder: NSCoder!) {
            name = aDecoder.decodeObjectForKey(nameKey) as String
            types = aDecoder.decodeObjectForKey(typesKey) as [String]
            uri = aDecoder.decodeObjectForKey(uriKey) as String
            
            super.init(coder: aDecoder)
        }
        
        required public init(jsonDictionary: [String : AnyObject]) {
            let jsonNSDict = jsonDictionary as NSDictionary
            
            name = jsonNSDict.objectForKey(nameKey) as String
            types = jsonNSDict.objectForKey(typesKey) as [String]
            uri = jsonNSDict.objectForKey(uriKey) as String
            
            super.init()
        }
        
        override public func encodeWithCoder(aCoder: NSCoder!) {
            aCoder.encodeObject(name, forKey: nameKey)
            aCoder.encodeObject(types, forKey: typesKey)
            aCoder.encodeObject(uri, forKey: uriKey)
        }
        
    }
    
}
