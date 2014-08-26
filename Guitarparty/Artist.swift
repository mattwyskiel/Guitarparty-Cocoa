//
//  Artist.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/12/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPArtist)
public class Artist: ModelObject {
    
    /// The artist's biography.
    public var bio: String
    /// The artist's name.
    public var name: String
    /// The artist's url-safe name.
    public var slug: String
    /// The URI for the artist, relative to the API host.
    public var uri: String
    
    let bioKey = "bio"
    let nameKey = "name"
    let slugKey = "slug"
    let uriKey = "uri"
    
    required public init(jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        bio = jsonNSDict.objectForKey(bioKey) as String
        name = jsonNSDict.objectForKey(nameKey) as String
        slug = jsonNSDict.objectForKey(slugKey) as String
        uri = jsonNSDict.objectForKey(uriKey) as String
    }
    
    required public init(coder aDecoder: NSCoder) {
        bio = aDecoder.decodeObjectForKey(bioKey) as String
        name = aDecoder.decodeObjectForKey(nameKey) as String
        slug = aDecoder.decodeObjectForKey(slugKey) as String
        uri = aDecoder.decodeObjectForKey(uriKey) as String
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(bio, forKey: bioKey)
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(slug, forKey: slugKey)
        aCoder.encodeObject(uri, forKey: uriKey)
    }
}
