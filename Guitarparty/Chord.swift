//
//  Chord.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Guitarparty.com. All rights reserved.
//

import UIKit

public class Chord: ModelObject, NSCoding {
    
    public var code: String
    public var imageUrl: NSURL
    public var instrument: Instrument
    public var name: String
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
        
        super.init()
    }
    
    public required init(coder aDecoder: NSCoder!) {
        code = aDecoder.decodeObjectForKey(codeKey) as String
        imageUrl = aDecoder.decodeObjectForKey(imageUrlKey) as NSURL
        instrument = aDecoder.decodeObjectForKey(instrumentKey) as Instrument
        name = aDecoder.decodeObjectForKey(nameKey) as String
        uri = aDecoder.decodeObjectForKey(uriKey) as String
        
        super.init(coder: aDecoder)
    }
    
    public override func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(code, forKey: codeKey)
        aCoder.encodeObject(imageUrl, forKey: imageUrlKey)
        aCoder.encodeObject(instrument, forKey: instrumentKey)
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(uri, forKey: uriKey)
    }
    
}

public class Instrument: ModelObject, NSCoding {
    
    var name: String
    var safeName: String
    var tuning: String
    
    let nameKey = "name"
    let safeNameKey = "safe_name"
    let tuningKey = "tuning"
    
    
    required public init(jsonDictionary: [String : AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        name = jsonNSDict.objectForKey(nameKey) as String
        safeName = jsonNSDict.objectForKey(safeNameKey) as String
        tuning = jsonNSDict.objectForKey(tuningKey) as String
        
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder!) {
        name = aDecoder.decodeObjectForKey(nameKey) as String
        safeName = aDecoder.decodeObjectForKey(safeNameKey) as String
        tuning = aDecoder.decodeObjectForKey(tuningKey) as String
        
        super.init(coder: aDecoder)
    }
    
    override public func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(safeName, forKey: safeNameKey)
        aCoder.encodeObject(tuning, forKey: tuningKey)
    }
}
