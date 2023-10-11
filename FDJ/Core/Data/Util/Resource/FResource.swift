//
//  FResource.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

enum FResource<Data> {
    case success(ResourceSuccess<Data>)
    case loading(ResourceLoading<Data>)
    case error(ResourceError<Data>)
    case empty(ResourceEmpty<Data>)
}
