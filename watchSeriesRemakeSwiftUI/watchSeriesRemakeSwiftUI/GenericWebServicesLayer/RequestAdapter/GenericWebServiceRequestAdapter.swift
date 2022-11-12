//
//  GenericWebServiceRequestAdapter.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Alamofire
import Foundation
import Combine

final class GenericWebServiceRequestAdapter: GenericWebServiceRequestAdaptable {

    // MARK: - METHODS
    func fetch<ParametersType>(request: GenericWebServiceRequestable,
                               parameters: ParametersType) -> AnyPublisher<DataResponse<Data, AFError>, Never>? where ParametersType : Encodable {
        guard let requestUrl = getUrlForRequest(request: request) else {
            return nil
        }
        AF.sessionConfiguration.timeoutIntervalForRequest = request.timeOut
        return AF.request(requestUrl,
                          method: request.method,
                          parameters: parameters,
                          encoder: getParameterEncoder(request: request),
                          headers: request.headers)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .publishData()
        .eraseToAnyPublisher()
    }

    // MARK: - OWN METHODS
    private func getUrlForRequest(request: GenericWebServiceRequestable) -> URL? {
        let baseUrlString: String = request.baseUrl
        guard var urlComponents = URLComponents(string: baseUrlString) else {
            return nil
        }
        urlComponents.path += request.endPointPath
        if let queriesItems = request.queryItems {
            urlComponents.queryItems = queriesItems
        }
        return urlComponents.url
    }

    private func getParameterEncoder(request: GenericWebServiceRequestable) -> ParameterEncoder {
        switch request.method {
        case .get, .head, .delete:
            return URLEncodedFormParameterEncoder(destination: .methodDependent)
        case .post, .put:
            return JSONParameterEncoder.default
        default:
            return URLEncodedFormParameterEncoder(destination: .methodDependent)
        }
    }

}
