//
//  Song.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPSong)
public class Song: ModelObject {
    
    /// List of the song's authors
    public var authors: [Author]
    /// The song's body; for example: "\ \ and there's [G]nothing I can [Am]do to keep\ \ from [G]crying, when he calls your name,"
    public var body: String
    /// An html-renderable version of the song's body
    public var htmlBody: String
    /// The song's body, stripped of the chords
    public var strippedBody: String
    /// List of all the chords used in this song.
    public var chords: [Chord]
    /// The identifier of this song.
    @objc(identifier) public var id: Int
    /// The permalink to the webpage of this song.
    public var permalink: NSURL
    /// The list of this song's tags.
    public var tags: [String]
    /// The song's title.
    public var title: String
    /// The song's uri, used to access the song via the API; relative to the API host (i.e. http://api.guitarparty.com)
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
    
    required public init?(coder aDecoder: NSCoder) {
        authors = aDecoder.decodeObjectForKey(authorsKey) as! [Author]
        body = aDecoder.decodeObjectForKey(bodyKey) as! String
        htmlBody = aDecoder.decodeObjectForKey(htmlBodyKey) as! String
        strippedBody = aDecoder.decodeObjectForKey(strippedBodyKey) as! String
        chords = aDecoder.decodeObjectForKey(chordsKey) as! [Chord]
        id = aDecoder.decodeObjectForKey(idKey) as! Int
        permalink = aDecoder.decodeObjectForKey(permalinkKey) as! NSURL
        tags = aDecoder.decodeObjectForKey(tagsKey) as! [String]
        title = aDecoder.decodeObjectForKey(titleKey) as! String
        uri = aDecoder.decodeObjectForKey(uriKey) as! String
    }
    
    required public init(jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        // Get author array set up
        authors = []
        let authorDictArray = jsonNSDict.objectForKey(authorsKey) as! Array<[String: AnyObject]>
        for authorDict in authorDictArray {
            let author = Author(jsonDictionary: authorDict)
            authors.append(author)
        }
        
        body = jsonNSDict.objectForKey(bodyKey) as! String
        htmlBody = jsonNSDict.objectForKey(htmlBodyKey) as! String
        strippedBody = jsonNSDict.objectForKey(strippedBodyKey) as! String
        
        // Get chord array set up
        chords = []
        let chordDictArray = jsonNSDict.objectForKey(authorsKey) as! Array<[String: AnyObject]>
        for chordDict in authorDictArray {
            let chord = Chord(jsonDictionary: chordDict)
            chords.append(chord)
        }
        
        id = jsonNSDict.objectForKey(idKey) as! Int
        permalink = NSURL(string: jsonNSDict.objectForKey(permalinkKey) as! String)!
        tags = jsonNSDict.objectForKey(tagsKey) as! [String]
        title = jsonNSDict.objectForKey(titleKey) as! String
        uri = jsonNSDict.objectForKey(uriKey) as! String
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
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
    public class Author: ModelObject {
        
        /// The author's name.
        public var name: String
        /// The song types.
        public var types: [String]
        /// The URI for the author, relative to the API host.
        public var uri: String
        
        let nameKey = "name"
        let typesKey = "types"
        let uriKey = "uri"
        
        required public init?(coder aDecoder: NSCoder) {
            name = aDecoder.decodeObjectForKey(nameKey) as! String
            types = aDecoder.decodeObjectForKey(typesKey) as! [String]
            uri = aDecoder.decodeObjectForKey(uriKey) as! String
        }
        
        required public init(jsonDictionary: [String : AnyObject]) {
            let jsonNSDict = jsonDictionary as NSDictionary
            
            name = jsonNSDict.objectForKey(nameKey) as! String
            types = jsonNSDict.objectForKey(typesKey) as! [String]
            uri = jsonNSDict.objectForKey(uriKey) as! String
        }
        
        public func encodeWithCoder(aCoder: NSCoder) {
            aCoder.encodeObject(name, forKey: nameKey)
            aCoder.encodeObject(types, forKey: typesKey)
            aCoder.encodeObject(uri, forKey: uriKey)
        }
        
    }
    
}
