//
//  KeyedDecodingContainerExtensions.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension KeyedDecodingContainer {
    
    public func decodeIfPresentSafe<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) -> T? where T : Decodable {
        try? decodeIfPresent(type, forKey: key)
    }
    
    /// Decode a value if present safe with default value
    /// - Parameters:
    ///   - type: type of value to decode
    ///   - key: key that the decoded value is associated with
    ///   - defaultValue: default value to use if decoded value is nil
    /// - Returns: decoded value or default
    public func decodeIfPresentSafe<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key, defaultValue:T) -> T where T : Decodable{
        return decodeIfPresentSafe(type, forKey: key) ?? defaultValue
    }
}
