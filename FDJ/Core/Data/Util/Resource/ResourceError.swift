//
//  ResourceError.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class ResourceError<Data> {
    var data: Data? = nil
    var error: NSError? = nil
    
    init(data: Data? = nil, _ error: NSError? = nil) {
        self.data = data
        self.error = error
    }
}
