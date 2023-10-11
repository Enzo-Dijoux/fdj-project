//
//  StringExtensions.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension Optional where Wrapped == String {
    /// Convert an optional string to an empty String
    var orEmpty: String {
        return self ?? ""
    }
}
