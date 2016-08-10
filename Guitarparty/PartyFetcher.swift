//
//  PartyFetcher.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/16/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

public class PartyFetcher: Fetcher {
   
    /**
    
    Creates a party. A Party on the Guitarparty.com platform is essentially a real-time channel which can be used to sync lyrics and chords to multiple users. While this is still a highly experimental feature we are most excited about this part of our system.
    
    - parameter requestBody: The request body to be provided with the request. The only required property on this object is the title
    - parameter completionHandler: The completion handler, which is passed the Party which was created and an error object. Both are optional values and it's either one or the other.
    
    */
    public class func createParty(requestBody: PartyPOSTRequestBody, completionHandler: (result: Party?, error: Error?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/parties/", method: .POST, body: requestBody.toJSONDict()) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let party = Party(json: jsonDict!)
                completionHandler(result: party, error: nil)
            }
        }
    }
    
    /**
    
    Updates a party. A Party on the Guitarparty.com platform is essentially a real-time channel which can be used to sync lyrics and chords to multiple users. While this is still a highly experimental feature we are most excited about this part of our system.
    
    - parameter partyURI: The uri of the party being updated
    - parameter requestBody: The request body to be provided with the request. There are no required parameters
    - parameter completionHandler: The completion handler, which is passed the Party which was updated and an error object. Both are optional values and it's either one or the other.
    
    */
    public class func updateParty(atURI partyURI: String, requestBody: PartyPUTRequestBody, completionHandler: (result: Party?, error: Error?) -> ()) {
        Fetcher.performRequest(endpoint: partyURI, method: .PUT, body: requestBody.toJSONDict()) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let party = Party(json: jsonDict!)
                completionHandler(result: party, error: nil)
            }
        }
    }
    
    /**
    
    Updates a party. A Party on the Guitarparty.com platform is essentially a real-time channel which can be used to sync lyrics and chords to multiple users. While this is still a highly experimental feature we are most excited about this part of our system.
    
    - parameter partyId: The id of the party being updated
    - parameter requestBody: The request body to be provided with the request. There are no required parameters
    - parameter completionHandler: The completion handler, which is passed the Party which was updated and an error object. Both are optional values and it's either one or the other.
    
    */
    public class func updateParty(forId partyId: String, requestBody: PartyPUTRequestBody, completionHandler: (result: Party?, error: Error?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/parties/\(partyId)", method: .PUT, body: requestBody.toJSONDict()) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let party = Party(json: jsonDict!)
                completionHandler(result: party, error: nil)
            }
        }
    }
    
    /**
    
    Gets a list of songs in a party
    
    - parameter partyId: The id of the party being updated
    - parameter completionHandler: The completion handler, which is passed a SongList of songs in the party and an error object. Both are optional values and it's either one or the other.
    
    */
    public class func getListOfSongs(inPartyWithId partyId: String, completionHandler: (result: SongList?, error: Error?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/parties/\(partyId)/songs/", method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error!)
                return
            }
            
            if jsonDict != nil {
                let songList = SongList(json: jsonDict!)
                completionHandler(result: songList, error: nil)
            }
        }
    }
    
    /**
    
    Posts a message to a given party
    
    - parameter message: The message to be sent
    - parameter partyId: The id of the party being updated
    - parameter completionHandler: The completion handler, which is passed a SongList of songs in the party and an error object. Both are optional values and it's either one or the other. Since messages are a one-time event in our system, they are considered volatile and you do not get a reference to the message you created.
    
    */
    public class func postMessage(_ message: PartyMessage, toParty partyId: String, completionHandler: (result: PartyMessage?, error: Error?) -> ()) {
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

public class PartyMessage {
    /// The title of the message
    public var title: String
    /// The content of the message
    public var content: String
    /**
    
    Designated initializer for the PartyMessage object
    
    - parameter title: The title of the message
    - parameter content: The content of the message
    
    */
    public init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    init(jsonDictionary: [String: AnyObject]) {
        let jsonNSDict = jsonDictionary as NSDictionary
        
        title = jsonNSDict.object(forKey: "title") as! String
        content = jsonNSDict.object(forKey: "content") as! String
    }
    
    func toJSONDict() -> [String: AnyObject] {
        return ["title": title, "content": content]
    }
}

public class PartyPOSTRequestBody {
    
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
    
    /**
    
    Designated initializer for the PartyPOSTRequestBody object
    
    - parameter title: The title of the message
    
    */
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

public class PartyPUTRequestBody {
    
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
