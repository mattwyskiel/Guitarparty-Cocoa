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

public protocol ModelObjectCollection : ModelObject, SequenceType, ArrayLiteralConvertible {
    typealias Element: ModelObject
    /**
        Array of objects
    */
    var objects: [Element] { get set }
    init(objects: [Element])
}

extension ModelObjectCollection {
    public func generate() -> IndexingGenerator<[Element]> {
        return objects.generate()
    }
    
    public init(arrayLiteral elements: Element...) {
        self.init(objects: elements)
    }
    
    public subscript(index: Int) -> Element {
        get {
            return objects[index]
        }
        set(newValue) {
            objects[index] = newValue
        }
    }
}