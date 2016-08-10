//
//  Utils.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

class Utils {
    
    class func customError(forNetworkError error: NSError) -> NSError? {
        var domain: String?
        var code: Int?
        var localizedDescription: String?
        
        if error.domain == NSURLErrorDomain {
            
            domain = NSURLErrorDomain
            
            switch error.code {
            case NSURLErrorUnknown:
                let errorMessage = "\(error.code) - \(error.localizedFailureReason)"
                NSException(name: .undefinedKeyException, reason: errorMessage, userInfo: error.userInfo).raise()
                
            case NSURLErrorNetworkConnectionLost:
                code = NSURLErrorNetworkConnectionLost
                localizedDescription = "It appears you have lost internet connection in the middle of the data fetch; try again when you regain connectivity."
                
            case NSURLErrorNotConnectedToInternet:
                code = NSURLErrorNotConnectedToInternet
                localizedDescription = "You are not connected to the internet. Please try again when your internet connection returns."
                
            case NSURLErrorBadServerResponse:
                code = DataFetchErrorConsts.DataCodes.serverError.rawValue
                localizedDescription = "There appears to be something wrong with the data we are getting back from the server. Please try again later."
                
            case NSURLErrorCallIsActive:
                code = NSURLErrorCallIsActive
                localizedDescription = "Since you are on a call, we are unable to fetch the most recent data. Please try again when you are off a call."
                
            case NSURLErrorDataNotAllowed:
                code = NSURLErrorDataNotAllowed
                localizedDescription = "Your cellular network is not allowing us to make this request right now. Please try again later."
                
            default:
                code = 0
                localizedDescription = "We were unable to fetch the most recent data; please try again later."
            }
        }
        if let domainName = domain {
            if let returnCode = code {
                if let localizedDescription = localizedDescription {
                    return NSError(domain: domainName, code: returnCode, userInfo: [NSLocalizedFailureReasonErrorKey:localizedDescription])
                }
            }
        }
        return nil
    }
    
    class func customError(for response: HTTPURLResponse) -> NSError? {
        
        let domain = DataFetchErrorConsts.ErrorDomain
        var code: Int
        var localizedDescription: String
        
        switch response.statusCode {
        case DataFetchErrorConsts.DataCodes.badRequest.rawValue:
            code = DataFetchErrorConsts.DataCodes.badRequest.rawValue
            localizedDescription = "Bad request - you may have missing or invalid parameters"
            
        case DataFetchErrorConsts.DataCodes.unauthorized.rawValue:
            code = DataFetchErrorConsts.DataCodes.unauthorized.rawValue
            localizedDescription = "Unauthorized - invalid API key"
            
        case DataFetchErrorConsts.DataCodes.notFound.rawValue:
            code = DataFetchErrorConsts.DataCodes.notFound.rawValue
            localizedDescription = "Not found - Requested resource not found"
            
        case DataFetchErrorConsts.DataCodes.serverError.rawValue:
            code = DataFetchErrorConsts.DataCodes.serverError.rawValue
            localizedDescription = "There appears to be something wrong with the data we are getting back from the server, or the data you are looking for was not found. Please try again later."
            
        default:
            code = 0
            localizedDescription = "We were unable to fetch the most recent data; please try again later."
        }
        
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedFailureReasonErrorKey:localizedDescription])
        
    }
   
}

public struct DataFetchErrorConsts {
    /**
        The error domain for Data Fetch-related errors
    */
    public static let ErrorDomain = "com.guitarparty.data-fetch-error"
    
    /**
        Status Codes for the Guitarparty API
    
        OK
         Represents server response code 200 - OK
        Created
         Represents server response code 201 - Created
        BadRequest
         Represents server response code 400 - Bad Request
        Unauthorized
         Represents server response code 403 - Forbidden
        NotFound
         Represents server response code 404 - Not Found
        ServerError
         Represents server response code 500 - Server Error
    */
    public enum DataCodes: Int {
        /**
            Represents server response code 200 - OK
        */
        case ok = 200
        /**
            Represents server response code 201 - Created
        */
        case created = 201
        /**
            Represents server response code 400 - Bad Request
        */
        case badRequest = 400
        /**
            Represents server response code 403 - Forbidden
        */
        case unauthorized = 403
        /**
            Represents server response code 404 - Not Found
        */
        case notFound = 404
        /**
            Represents server response code 500 - Server Error
        */
        case serverError = 500
    }
}
