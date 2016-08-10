//
//  Artist.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/12/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

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
    
    required public init(json jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        bio = jsonNSDict.object(forKey: bioKey) as! String
        name = jsonNSDict.object(forKey: nameKey) as! String
        slug = jsonNSDict.object(forKey: slugKey) as! String
        uri = jsonNSDict.object(forKey: uriKey) as! String
    }
    
    required public init?(coder aDecoder: NSCoder) {
        bio = aDecoder.decodeObject(forKey: bioKey) as! String
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        slug = aDecoder.decodeObject(forKey: slugKey) as! String
        uri = aDecoder.decodeObject(forKey: uriKey) as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(bio, forKey: bioKey)
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(slug, forKey: slugKey)
        aCoder.encode(uri, forKey: uriKey)
    }
}
