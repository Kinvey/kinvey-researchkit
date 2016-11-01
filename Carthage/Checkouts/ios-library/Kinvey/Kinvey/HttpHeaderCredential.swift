//
//  HttpHeaderCredential.swift
//  Kinvey
//
//  Created by Victor Barros on 2016-01-19.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Foundation

class HttpHeaderCredential: Credential {
    
    var authorizationHeader: String?
    
    init(_ authorizationHeaderValue: String) {
        authorizationHeader = authorizationHeaderValue
    }
    
}
