//
//  ArtistFetcher.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/12/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import UIKit

@objc(GPArtistFetcher)
public class ArtistFetcher: Fetcher {
   
    /**
    
    Queries for artists using the provided query string, passing the results to a completion handler.
    
    Note: Make sure the query is a url-safe string.
    
    :param: query The query string used to search for songs
    :param: completionHandler The completion handler, which is passed a ArtistList of search results and an error object. Both are optional values and it's either one or the other.
    
    */
    public func searchForArtists(#query: String, completionHandler: (results: ArtistList?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/artists/?query=\(query)", method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(results: nil, error: error)
                return
            }
            if jsonDict != nil {
                let artistList = ArtistList(jsonDictionary: jsonDict!)
                completionHandler(results: artistList, error: nil)
            }
        }
    }
    
    /**
    
    Fetches an artist with the passed-in URI
    
    :param: uri The uri matching an artist in the database to be fetched. Various parts of the API return songs or references to songs. These references generally include a uri attribute which allows you to retrieve more information about the song.
    :param: completionHandler The completion handler, which is passed the results in the form of a Artist object and an error object. Both are optional values and it's either one or the other.
    
    Note: The uri parameter is always relative to the API host (i.e. http://api.guitarparty.com)
    
    */
    public func getArtist(#uri: String, completionHandler: (result: Artist?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: uri, method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error)
                return
            }
            if jsonDict != nil {
                let artist = Artist(jsonDictionary: jsonDict!)
                completionHandler(result: artist, error: nil)
            }
        }
    }
    
    /**
    
    Fetches an artist with the passed-in identifier.
    
    :param: id The identifier matching an artist in the database to be fetched.
    :param: completionHandler The completion handler, which is passed the results in the form of an Artist object and an error object. Both are optional values and it's either one or the other.
    
    */

    public func getArtist(#id: Int, completionHandler: (result: Artist?, error: NSError?) -> ()) {
        Fetcher.performRequest(endpoint: "/v2/artists/\(id)/", method: .GET) { (jsonDict, error) -> () in
            if error != nil {
                completionHandler(result: nil, error: error)
                return
            }
            if jsonDict != nil {
                let artist = Artist(jsonDictionary: jsonDict!)
                completionHandler(result: artist, error: nil)
            }
        }
    }
    
}
