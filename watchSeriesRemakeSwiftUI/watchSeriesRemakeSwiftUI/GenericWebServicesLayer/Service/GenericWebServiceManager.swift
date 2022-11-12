//
//  GenericWebServiceManager.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Foundation
import Combine

final class GenericWebServiceManager<SuccessResponse: Codable,
                                     ErrorResponse: Codable>: NSObject, ObservableObject {

    // MARK: - PROPERTIES
    private let requestAdapter: GenericWebServiceRequestAdaptable
    private let request: GenericWebServiceRequestable
    private let jsonDecoder = JSONDecoder()
    private var cancellables = Set<AnyCancellable>()


    // MARK: - INIT
    init(requestAdapter: GenericWebServiceRequestAdaptable = GenericWebServiceRequestAdapter(),
         request: GenericWebServiceRequestable) {
        self.requestAdapter = requestAdapter
        self.request = request
        super.init()
    }

    // MARK: - METHODS
    func fetchModel<ParametersType: Codable>(parameters: ParametersType) -> AnyPublisher<SuccessResponse, GenericWebServiceGenericError<ErrorResponse>> {
        let publisher = requestAdapter.fetch(request: request, parameters: parameters)
        return publisher
            .tryMap({ try self.tryMapToReponse(data: $0) })
            .mapError({ self.mapError(error: $0) })
            .eraseToAnyPublisher()
    }

    // MARK: - OWN METHODS
    func tryMapToReponse(data: Data) throws -> SuccessResponse {
        do {
            let responseModel = try jsonDecoder.decode(SuccessResponse.self, from: data)
            return responseModel
        } catch {
            if let errorModel = try? jsonDecoder.decode(ErrorResponse.self,
                                                        from: data) {
                throw GenericWebServiceGenericError<ErrorResponse>.modelError(model: errorModel)
            } else {
                throw GenericWebServiceGenericError<ErrorResponse>.decodeError(error: error)
            }
        }
    }

    func mapError(error: Error) -> GenericWebServiceGenericError<ErrorResponse> {
        guard let mappedError = error as? GenericWebServiceGenericError<ErrorResponse> else {
            return .unknow(error: error)
        }
        return mappedError
    }

}
