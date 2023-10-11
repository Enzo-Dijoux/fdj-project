//
//  ResourceEmpty.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class ResourceEmpty<Data> {
    var data: Data?
    
    init(data: Data? = nil) {
        self.data = data
    }
}
