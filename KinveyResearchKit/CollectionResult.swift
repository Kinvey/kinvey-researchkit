//
//  CollectionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

class CollectionResult: Result {
    
    dynamic var results: [Result]?
    
    var firstResult: Result? {
        get { return results?.first }
    }
    
    internal convenience init(collectionResult: ORKCollectionResult) {
        self.init(result: collectionResult)
        
        results = build(collectionResult.results)
    }
    
    override func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        results <- map["results"]
    }
    
}
