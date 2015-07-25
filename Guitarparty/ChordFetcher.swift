//
//  ChordFetcher.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/25/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPChordFetcher)
public class ChordFetcher: Fetcher {
    
    /**
    
    Queries for chords using the provided query string, passing the results to a completion handler.
    
    Note: Make sure the query is a url-safe string.
    
    - parameter query: The query string used to search for songs. You can search by chord name or by the chord fingering.
    - parameter completionHandler: The completion handler, which is passed a ChordList of search results and an error object. Both are optional values and it's either one or the other.
    
    */
    public class func searchChords(query query: String, completionHandler: (results: ChordList?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/chords/?query=\(query)", method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(results: nil, error: error)
                return
            }
            if jsonDict != nil {
                let chordList = ChordList(jsonDictionary: jsonDict!)
                completionHandler(results: chordList, error: nil)
            }
        }
    }
    
    /**
    
    Queries for all possible variations of a chord, passing the results to a completion handler.
    
    - parameter chordId: The chord code
    - parameter completionHandler: The completion handler, which is passed a ChordList of variation results and an error object. Both are optional values and it's either one or the other.
    
    */
    public class func getVariations(forChord chordId: String, completionHandler: (results: ChordList?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/chords/\(chordId)?variations=true", method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(results: nil, error: error)
                return
            }
            if jsonDict != nil {
                let chordList = ChordList(jsonDictionary: jsonDict!)
                completionHandler(results: chordList, error: nil)
            }
        }
    }
    
}