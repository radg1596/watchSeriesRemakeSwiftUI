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
    private let subjectPublisherForResult = PassthroughSubject<SuccessResponse, GenericWebServiceGenericError<ErrorResponse>>()
    private var cancellables = Set<AnyCancellable>()

    enum InternalError: Error {
        case canNotBuildAdapter
    }

    // MARK: - INIT
    init(requestAdapter: GenericWebServiceRequestAdaptable = GenericWebServiceRequestAdapter(),
         request: GenericWebServiceRequestable) {
        self.requestAdapter = requestAdapter
        self.request = request
        super.init()
    }

    // MARK: - METHODS
    func fetchModel<ParametersType: Codable>(parameters: ParametersType) -> AnyPublisher<SuccessResponse, GenericWebServiceGenericError<ErrorResponse>> {
        guard let publisher = requestAdapter.fetch(request: request, parameters: parameters) else {
            return Fail(error: GenericWebServiceGenericError<ErrorResponse>.unknow(error: InternalError.canNotBuildAdapter)).eraseToAnyPublisher()
        }
        publisher.sink { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .failure(let error):
                self.subjectPublisherForResult.send(completion: .failure(GenericWebServiceGenericError<ErrorResponse>.serviceFailure(statusCode: error.responseCode ?? .zero)))
            case .success(let data):
                do {
                    let responseModel = try JSONDecoder().decode(SuccessResponse.self, from: data)
                    self.subjectPublisherForResult.send(responseModel)
                } catch {
                    if let errorModel = try? self.jsonDecoder.decode(ErrorResponse.self, from: data) {
                        self.subjectPublisherForResult.send(completion: .failure(GenericWebServiceGenericError<ErrorResponse>.modelError(model: errorModel)))
                    } else {
                        self.subjectPublisherForResult.send(completion: .failure(GenericWebServiceGenericError<ErrorResponse>.decodeError(error: error)))
                    }
                }
            }
        }
        .store(in: &cancellables)
        return subjectPublisherForResult.eraseToAnyPublisher()
    }

}
