//
//  Chord.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

public class Chord: ModelObject {
    
    /// The code for the chord in the database; for example, the code for Am = "xo221o".
    public var code: String
    /// The URL for an image of the chord's diagram.
    public var imageUrl: URL
    /// The instrument that the chord is played on.
    public var instrument: Instrument
    /// The name of the chord.
    public var name: String
    /// The URI of the chord in the database.
    public var uri: String
    
    let codeKey = "code"
    let imageUrlKey = "image_url"
    let instrumentKey = "instrument"
    let nameKey = "name"
    let uriKey = "uri"
   
    public required init(json: [String:AnyObject]) {
        let jsonNSDict = json as NSDictionary
        
        code = jsonNSDict.object(forKey: codeKey) as! String
        
        let imgUrlString = jsonNSDict.object(forKey: imageUrlKey) as! String
        imageUrl = URL(string: imgUrlString)!
        
        let instrumentDictionary = jsonNSDict.object(forKey: instrumentKey) as! [String:AnyObject]
        instrument = Instrument(json: instrumentDictionary)
        
        name = jsonNSDict.object(forKey: nameKey) as! String
        
        uri = jsonNSDict.object(forKey: uriKey) as! String
    }
    
    public required init?(coder aDecoder: NSCoder) {
        code = aDecoder.decodeObject(forKey: codeKey) as! String
        imageUrl = aDecoder.decodeObject(forKey: imageUrlKey) as! URL
        instrument = aDecoder.decodeObject(forKey: instrumentKey) as! Instrument
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        uri = aDecoder.decodeObject(forKey: uriKey) as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(code, forKey: codeKey)
        aCoder.encode(imageUrl, forKey: imageUrlKey)
        aCoder.encode(instrument, forKey: instrumentKey)
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(uri, forKey: uriKey)
    }
    
}

public class Instrument: ModelObject {
    
    /// The name of the instrument.
    public var name: String
    /// The url-safe name of the instrument, for queries, input into image names, etc.
    public var safeName: String
    /// The tuning of the instrument; for example, the tuning of a guitar is "EADGBE"
    public var tuning: String
    
    let nameKey = "name"
    let safeNameKey = "safe_name"
    let tuningKey = "tuning"
    
    
    required public init(json jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        name = jsonNSDict.object(forKey: nameKey) as! String
        safeName = jsonNSDict.object(forKey: safeNameKey) as! String
        tuning = jsonNSDict.object(forKey: tuningKey) as! String
    }
    
    required public init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        safeName = aDecoder.decodeObject(forKey: safeNameKey) as! String
        tuning = aDecoder.decodeObject(forKey: tuningKey) as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(safeName, forKey: safeNameKey)
        aCoder.encode(tuning, forKey: tuningKey)
    }
}
