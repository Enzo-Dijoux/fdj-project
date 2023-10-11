//
//  FResponse.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Alamofire

class FResponse<T> {
    private final var rawResponse: HTTPURLResponse!
    var error: NSError?
    var body: T?
    var progress: Progress?
    
    init(rawResponse: HTTPURLResponse = HTTPURLResponse(), error: NSError? = nil, body: T? = nil, progress: Progress? = nil) {
        self.rawResponse = rawResponse
        self.error = error
        self.body = body
        self.progress = progress
    }
    
    /// The raw response from the HTTP client.
    public func raw() -> HTTPURLResponse {
        return rawResponse
    }
    
    /// HTTP status code.
    public func code() -> Int {
        return rawResponse.statusCode
    }
    
    /// HTTP headers.
    public func headers() -> HTTPHeaders  {
        return rawResponse.headers
    }
    
    /// Returns true if rawResponse.statusCode is in the range [200..300]
    public func isSuccessful() -> Bool {
        let successRange = 200...300
        return successRange.contains(code())
    }
    
    public func isFinished() -> Bool? {
        progress?.isFinished
    }
    
    public func isLoading() -> Bool {
        isFinished() == false
    }
    
    public func toString() -> String {
        return rawResponse.description
    }
}
