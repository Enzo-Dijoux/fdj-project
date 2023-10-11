//
//  FResponseExtensions.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Alamofire

extension HTTPURLResponse {
    ///By default an HTTPURLResponse have a 200 status code, this function is used to create a response with a 500 status code, for the errors.
    class func defaultErrorResponse() -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "http://localhost/")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    }
    
    func toFResponse<T>(body: T? = nil, error: NSError? = nil) -> FResponse<T> {
        FResponse(rawResponse: self, error: error, body: body)
    }
}

extension AFError {
    func toFResponse<T>() -> FResponse<T> {
        let defaultErrorResponse: HTTPURLResponse = .defaultErrorResponse()
        return FResponse(rawResponse: defaultErrorResponse, error: NSError(domain: "", code: defaultErrorResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: localizedDescription]))
    }
}

extension Progress {
    func toFResponse<T>() -> FResponse<T> {
        FResponse(progress: self)
    }
}

extension FResponse {
    @discardableResult
    func onSuccess(completion: @escaping (T) -> Void) -> FResponse {
        if (isSuccessful() && body != nil) {
            completion(body!)
        }
        return self
    }

    @discardableResult
    func onFail(completion: @escaping (NSError) -> Void) -> FResponse {
        if (!isSuccessful()) {
            completion(error ?? NSError())
        }
        return self
    }
    
    @discardableResult
    func onLoading(completion: @escaping (Progress) -> Void) -> FResponse {
        if (isLoading() && progress != nil) {
            completion(progress!)
        }
        return self
    }
}
