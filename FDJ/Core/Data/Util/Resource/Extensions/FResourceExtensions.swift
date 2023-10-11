//
//  FResourceExtensions.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension FResource {
    @discardableResult
    func onSuccess(_ completion: (ResourceSuccess<Data>) -> ()) -> Self {
        guard case let .success(value) = self else { return self }
        completion(value)
        return self
    }
    
    @discardableResult
    func onLoading(_ completion: (ResourceLoading<Data>) -> ()) -> Self {
        guard case let .loading(value) = self else { return self }
        completion(value)
        return self
    }
    
    @discardableResult
    func onError(_ completion: (ResourceError<Data>) -> ()) -> Self {
        guard case let .error(error) = self else { return self }
        completion(error)
        return self
    }
    
    @discardableResult
    func onEmpty(_ completion: () -> ()) -> Self {
        guard case .empty = self else { return self }
        completion()
        return self
    }
    
    func isLoading() -> Bool {
        if case .loading(_) = self {
            return true
        } else {
            return false
        }
    }
    
    func getValue() -> Data? {
        switch self {
        case .success(let resourceSuccess):
            return resourceSuccess.data
        case .loading(let loading):
            return loading.data
        default:
            return nil
        }
    }
    
    func getValueOrDefault(_ defaultValue: Data) -> Data {
        return getValue() ?? defaultValue
    }
}
