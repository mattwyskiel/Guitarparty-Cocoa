//
//  SongFetcher.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/10/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

public class SongFetcher: Fetcher {
    
    /**
    
    Queries for songs using the provided query string, passing the results to a completion handler.
    
    Note: Make sure the query is a url-safe string.
    
    - parameter query: The query string used to search for songs
    - parameter completionHandler: The completion handler, which is passed a SongList of search results and an error object. Both are optional values and it's either one or the other.
    
    */
    public class func searchForSongs(withQuery query: String, completionHandler: (results: SongList?, error: Error?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/songs/?query=\(query)/", method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(results: nil, error: error)
                return
            }
            if jsonDict != nil {
                let songList = SongList(json: jsonDict!)
                completionHandler(results: songList, error: nil)
            }
        }
    }
    
    /**
    
    Fetches a song with the passed-in URI
    
    - parameter uri: The uri matching a song in the database to be fetched. Various parts of the API return songs or references to songs. These references generally include a uri attribute which allows you to retrieve more information about the song.
    - parameter completionHandler: The completion handler, which is passed the results in the form of a Song object and an error object. Both are optional values and it's either one or the other.
    
    Note: The uri parameter is always relative to the API host (i.e. http://api.guitarparty.com)
    
    */
    public class func getSong(atURI uri: String, completionHandler: (result: Song?, error: Error?) -> ()) {
        Fetcher.performRequest(endpoint: uri, method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error)
                return
            }
            if jsonDict != nil {
                let song = Song(json: jsonDict!)
                completionHandler(result: song, error: nil)
            }
        }
    }
    
    /**
    
    Fetches a song with the passed-in identifier.
    
    - parameter id: The identifier matching a song in the database to be fetched.
    - parameter completionHandler: The completion handler, which is passed the results in the form of a Song object and an error object. Both are optional values and it's either one or the other.
    
    */
    public class func getSong(forId id: Int, completionHandler: (result: Song?, error: Error?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/songs/\(id)/", method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error)
                return
            }
            if jsonDict != nil {
                let song = Song(json: jsonDict!)
                completionHandler(result: song, error: nil)
            }
        }
    }
    
}
