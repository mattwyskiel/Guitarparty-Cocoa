//
//  Song.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

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
    public var permalink: URL
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
        authors = aDecoder.decodeObject(forKey: authorsKey) as! [Author]
        body = aDecoder.decodeObject(forKey: bodyKey) as! String
        htmlBody = aDecoder.decodeObject(forKey: htmlBodyKey) as! String
        strippedBody = aDecoder.decodeObject(forKey: strippedBodyKey) as! String
        chords = aDecoder.decodeObject(forKey: chordsKey) as! [Chord]
        id = aDecoder.decodeObject(forKey: idKey) as! Int
        permalink = aDecoder.decodeObject(forKey: permalinkKey) as! URL
        tags = aDecoder.decodeObject(forKey: tagsKey) as! [String]
        title = aDecoder.decodeObject(forKey: titleKey) as! String
        uri = aDecoder.decodeObject(forKey: uriKey) as! String
    }
    
    required public init(json jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        // Get author array set up
        authors = []
        let authorDictArray = jsonNSDict.object(forKey: authorsKey) as! Array<[String: AnyObject]>
        for authorDict in authorDictArray {
            let author = Author(json: authorDict)
            authors.append(author)
        }
        
        body = jsonNSDict.object(forKey: bodyKey) as! String
        htmlBody = jsonNSDict.object(forKey: htmlBodyKey) as! String
        strippedBody = jsonNSDict.object(forKey: strippedBodyKey) as! String
        
        // Get chord array set up
        chords = []
        let chordDictArray = jsonNSDict.object(forKey: authorsKey) as! Array<[String: AnyObject]>
        for chordDict in chordDictArray {
            let chord = Chord(json: chordDict)
            chords.append(chord)
        }
        
        id = jsonNSDict.object(forKey: idKey) as! Int
        permalink = URL(string: jsonNSDict.object(forKey: permalinkKey) as! String)!
        tags = jsonNSDict.object(forKey: tagsKey) as! [String]
        title = jsonNSDict.object(forKey: titleKey) as! String
        uri = jsonNSDict.object(forKey: uriKey) as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(authors, forKey: authorsKey)
        aCoder.encode(body, forKey: bodyKey)
        aCoder.encode(htmlBody, forKey: htmlBodyKey)
        aCoder.encode(strippedBody, forKey: strippedBodyKey)
        aCoder.encode(chords, forKey: chordsKey)
        aCoder.encode(id, forKey: idKey)
        aCoder.encode(permalink, forKey: permalinkKey)
        aCoder.encode(tags, forKey: tagsKey)
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(uri, forKey: uriKey)
    }
    
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
            name = aDecoder.decodeObject(forKey: nameKey) as! String
            types = aDecoder.decodeObject(forKey: typesKey) as! [String]
            uri = aDecoder.decodeObject(forKey: uriKey) as! String
        }
        
        required public init(json jsonDictionary: [String : AnyObject]) {
            let jsonNSDict = jsonDictionary as NSDictionary
            
            name = jsonNSDict.object(forKey: nameKey) as! String
            types = jsonNSDict.object(forKey: typesKey) as! [String]
            uri = jsonNSDict.object(forKey: uriKey) as! String
        }
        
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(name, forKey: nameKey)
            aCoder.encode(types, forKey: typesKey)
            aCoder.encode(uri, forKey: uriKey)
        }
        
    }
    
}
