//
//  ModelObject.swift
//  Guitarparty
//
//  Created by Matthew Wyskiel on 8/8/14.
//  Copyright (c) 2014 Matthew Wyskiel. All rights reserved.
//

import Foundation

@objc(GPModelObject)
public protocol ModelObject: NSCoding {
    init(jsonDictionary: [String : AnyObject])
}

public protocol ModelObjectCollection : ModelObject, SequenceType {
    typealias Element: ModelObject
    /**
        Array of objects
    */
    var objects: [Element] { get set }
}