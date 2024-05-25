//
//  HTTPClient.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 25/05/2024.
//

import Foundation
import Alamofire

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        print("sending request to url \(urlComponents.url?.absoluteString ?? "")")
        
        guard let url = urlComponents.url?.absoluteString.removingPercentEncoding else { return .failure(.invalidURL) }

        do {
            var urlRequest = try URLRequest(url: url.asURL())
            urlRequest.httpMethod = endpoint.method.rawValue
            urlRequest.allHTTPHeaderFields = endpoint.header

            if let body = endpoint.body {
                urlRequest.httpBody = body
            }

            let request = AF.request(urlRequest).serializingDecodable(responseModel)
            
            guard let response = await request.response.response else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? await request.value else {
                    return .failure(.decode)
                }
                
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                print("Response status code: \(response.statusCode)")
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
