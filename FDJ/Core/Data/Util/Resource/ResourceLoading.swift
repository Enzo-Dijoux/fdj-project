//
//  ResourceLoading.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class ResourceLoading<Data> {
    var data: Data?
    var progress: Progress?
    
    init(data: Data? = nil, progress: Progress? = nil) {
        self.data = data
        self.progress = progress
    }
}
