//
//  Chord.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPChord)
public class Chord: ModelObject {
    
    /// The code for the chord in the database; for example, the code for Am = "xo221o".
    public var code: String
    /// The URL for an image of the chord's diagram.
    public var imageUrl: NSURL
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
   
    public required init(jsonDictionary: [String:AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        code = jsonNSDict.objectForKey(codeKey) as String
        
        let imgUrlString = jsonNSDict.objectForKey(imageUrlKey) as String
        imageUrl = NSURL(string: imgUrlString)
        
        let instrumentDictionary = jsonNSDict.objectForKey(instrumentKey) as [String:AnyObject]
        instrument = Instrument(jsonDictionary: instrumentDictionary)
        
        name = jsonNSDict.objectForKey(nameKey) as String
        
        uri = jsonNSDict.objectForKey(uriKey) as String
    }
    
    public required init(coder aDecoder: NSCoder) {
        code = aDecoder.decodeObjectForKey(codeKey) as String
        imageUrl = aDecoder.decodeObjectForKey(imageUrlKey) as NSURL
        instrument = aDecoder.decodeObjectForKey(instrumentKey) as Instrument
        name = aDecoder.decodeObjectForKey(nameKey) as String
        uri = aDecoder.decodeObjectForKey(uriKey) as String
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(code, forKey: codeKey)
        aCoder.encodeObject(imageUrl, forKey: imageUrlKey)
        aCoder.encodeObject(instrument, forKey: instrumentKey)
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(uri, forKey: uriKey)
    }
    
}

@objc(GPInstrument)
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
    
    
    required public init(jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        name = jsonNSDict.objectForKey(nameKey) as String
        safeName = jsonNSDict.objectForKey(safeNameKey) as String
        tuning = jsonNSDict.objectForKey(tuningKey) as String
    }
    
    required public init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as String
        safeName = aDecoder.decodeObjectForKey(safeNameKey) as String
        tuning = aDecoder.decodeObjectForKey(tuningKey) as String
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(safeName, forKey: safeNameKey)
        aCoder.encodeObject(tuning, forKey: tuningKey)
    }
}
