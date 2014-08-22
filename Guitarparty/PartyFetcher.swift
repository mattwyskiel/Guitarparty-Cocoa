//
//  PartyFetcher.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/16/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import UIKit

@objc(GPPartyFetcher)
public class PartyFetcher: Fetcher {
   
    public class func createParty(#requestBody: PartyPOSTRequestBody, completionHandler: (result: Party?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/parties/", method: .POST, body: requestBody.toJSONDict()) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let party = Party(jsonDictionary: jsonDict!)
                completionHandler(result: party, error: nil)
            }
        }
    }
    
    public class func updateParty(#partyURI: String, requestBody: PartyPUTRequestBody, completionHandler: (result: Party?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: partyURI, method: .PUT, body: requestBody.toJSONDict()) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let party = Party(jsonDictionary: jsonDict!)
                completionHandler(result: party, error: nil)
            }
        }
    }
    
    public class func updateParty(id partyId: String, requestBody: PartyPUTRequestBody, completionHandler: (result: Party?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/parties/\(partyId)", method: .PUT, body: requestBody.toJSONDict()) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let party = Party(jsonDictionary: jsonDict!)
                completionHandler(result: party, error: nil)
            }
        }
    }
    
    public class func getListOfSongsInParty(id partyId: String, completionHandler: (result: SongList?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/parties/\(partyId)/songs/", method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let songList = SongList(jsonDictionary: jsonDict!)
                completionHandler(result: songList, error: nil)
            }
        }
    }
    
    public class func postMessage(message: PartyMessage, toParty partyId: String, completionHandler: (result: PartyMessage?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/parties/\(partyId)}/messages/", method: .POST, body: message.toJSONDict()) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let message = PartyMessage(jsonDictionary: jsonDict!)
                completionHandler(result: message, error: nil)
            }
        }
    }
    
}

@objc(GPPartyMessage) public class PartyMessage {
    public var title: String
    public var content: String
    public init(title: String, message: String) {
        self.title = title
        self.content = message
    }
    
    init(jsonDictionary: [String: AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        title = jsonNSDict.objectForKey("title") as String
        content = jsonNSDict.objectForKey("content") as String
    }
    
    func toJSONDict() -> [String: AnyObject] {
        return ["title": title, "content": content]
    }
}

@objc(GPPartyPOSTRequestBody) public class PartyPOSTRequestBody {
    
    /// Title of party (required for creating parties)
    public var title: String
    /// Description of party (optional)
    public var description: String?
    /// The song that users who just logged on to the party see initially (optional)
    public var currentSongID: Int?
    /// An id of a songbook that can be used to seed the party (optional)
    public var songbookSeed: Int?
    /// A JSON array of song ID's that can be used to seed the party (optional)
    public var songSeed: [Int]?
    
    public init(title: String) {
        self.title = title
    }
    
    func toJSONDict() -> [String: AnyObject] {
        var jsonDict: [String: AnyObject] = ["title": title]
        
        if description != nil {
            jsonDict["description"] = description!
        }
        
        if currentSongID != nil {
            jsonDict["current_song"] = currentSongID!
        }
        
        if songbookSeed != nil {
            jsonDict["songbook_seed"] = songbookSeed!
        }
        
        if songSeed != nil {
            jsonDict["song_seed"] = songSeed!
        }
        
        return jsonDict
    }
}

@objc(GPPartyPUTRequestBody) public class PartyPUTRequestBody {
    
    /// Title of party (optional)
    public var title: String?
    /// Description of party (optional)
    public var description: String?
    /// The song that users who just logged on to the party see initially (optional)
    public var currentSongID: Int?
    /// An id of a songbook that can be used to seed the party (optional)
    public var songbookSeed: Int?
    /// A JSON array of song ID's that can be used to seed the party (optional)
    public var songSeed: [Int]?
    
    func toJSONDict() -> [String: AnyObject] {
        var jsonDict: [String: AnyObject] = [:]
        
        if title != nil {
            jsonDict["title"] = title!
        }
        
        if description != nil {
            jsonDict["description"] = description!
        }
        
        if currentSongID != nil {
            jsonDict["current_song"] = currentSongID!
        }
        
        if songbookSeed != nil {
            jsonDict["songbook_seed"] = songbookSeed!
        }
        
        if songSeed != nil {
            jsonDict["song_seed"] = songSeed!
        }
        
        return jsonDict
    }
}
