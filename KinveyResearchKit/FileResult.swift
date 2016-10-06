//
//  FileResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-05.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

class URLBase64Transform: TransformType {
    
    typealias Object = URL
    typealias JSON = String
    
    let contentType: String?
    
    init(contentType: String?) {
        self.contentType = contentType
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let url = value,
            let data = try? Data(contentsOf: url)
        {
            let contentType = self.contentType ?? ""
            return "data:\(contentType);base64,\(data.base64EncodedString())"
        }
        return nil
    }
    
}

class URLContentStringTransform: TransformType {
    
    typealias Object = URL
    typealias JSON = String
    
    let contentType: String?
    
    init(contentType: String?) {
        self.contentType = contentType
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let url = value,
            let data = try? Data(contentsOf: url),
            let string = String(data: data, encoding: .utf8)
        {
            let contentType = self.contentType ?? ""
            return "data:\(contentType);charset=utf-8,\(string)"
        }
        return nil
    }
    
}

open class FileResult: Result {
    
    dynamic var contentType: String?
    dynamic var fileURL: URL?
    
    convenience init(fileResult: ORKFileResult) {
        self.init(result: fileResult)
        
        contentType = fileResult.contentType
        fileURL = fileResult.fileURL
    }
    
    override open class func collectionName() -> String {
        return "FileResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        self.contentType <- map["contentType"]
        var contentType: String? = nil
        switch map.mappingType {
        case .toJSON:
            contentType = self.contentType
        case .fromJSON:
            var value: String? = nil
            value <- map["contentType"]
            contentType = value
        }
        if let contentType = contentType {
            switch contentType {
            case "plain/text", "application/json":
                fileURL <- (map["fileURL"], URLContentStringTransform(contentType: contentType))
            default:
                fileURL <- (map["fileURL"], URLBase64Transform(contentType: contentType))
            }
        } else {
            fileURL <- (map["fileURL"], URLBase64Transform(contentType: contentType))
        }
    }
    
}
