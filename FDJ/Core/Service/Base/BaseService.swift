//
//  BaseService.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Alamofire

private let API_BASE_URL = "https://www.thesportsdb.com/api/v1/json/50130162/"

//TODO: Check if headers implementation is needed
class BaseService {
    
    func getRequest<T>(path: String, parameters: Parameters? = nil, headers: HTTPHeaders = HTTPHeaders(), parser: BaseParser? = nil) async -> FResponse<T>? {
        return await startRequest(method: .get, path: path, parameters: parameters, headers: headers, parser: parser)
    }

    private func startRequest<T>(method: HTTPMethod, path: String, parameters: Parameters?, headers: HTTPHeaders, parser: BaseParser? = nil) async -> FResponse<T>? {
        let request = createRequest(method: method, url: API_BASE_URL + path, parameters: parameters, headers: headers)
        
        return await withCheckedContinuation { continuation in
            request.responseData { response in
                continuation.resume(returning: self.handleResponse(response, request: request, parser: parser))
            }
        }
    }
    
    private func createRequest(method: HTTPMethod, url: String, parameters: Parameters?, headers: HTTPHeaders) -> DataRequest {
        return AF.request(url, method: method, parameters: parameters, headers: headers)
    }
    
    private func handleResponse<T>(_ response: AFDataResponse<Data>, request: DataRequest, parser: BaseParser? = nil) -> FResponse<T>? {
        print(request.metrics)
        print(response.result)
        switch response.result {
        case let .success(data) :
            return handleSuccess(data: data, parser: parser, response: response)
        case .failure(let afError):
            return handleError(afError: afError, response: response)
        }
    }
    
    private func handleSuccess<T>(data: Data, parser: BaseParser?, response: AFDataResponse<Data>) -> FResponse<T>? {
        if parser != nil, let result = parser?.parse(withResponse: data as NSData, headers: (response.response?.allHeaderFields)!) as? T {
            print(String(data: data, encoding: .utf8))
            return response.response?.toFResponse(body: result)
        } else {
            //TODO: Remove this if not needed
            return response.response?.toFResponse(body: () as? T)
        }
    }
    
    private func handleError<T>(afError: AFError, response: AFDataResponse<Data>) -> FResponse<T>? {
        print(afError.localizedDescription)
        guard let httpResponse = response.response else {
            return afError.toFResponse()
        }
        
        if (200...205).contains(httpResponse.statusCode) {
            return httpResponse.toFResponse(body: () as? T)
        }
        
        let statusCode = httpResponse.statusCode
        let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: afError.localizedDescription])
        
        return httpResponse.toFResponse(error: error)
    }
    
    //TODO: Remove this
//    private func generateDefaultHeaders() -> HTTPHeaders {
//        var headers: HTTPHeaders = [:]
//        headers.add(.contentType("application/json"))
//        return headers
//    }
}
