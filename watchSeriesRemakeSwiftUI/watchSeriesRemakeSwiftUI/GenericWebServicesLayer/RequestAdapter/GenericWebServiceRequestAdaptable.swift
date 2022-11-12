//
//  GenericWebServiceRequestAdaptable.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Foundation
import Combine
import Alamofire

protocol GenericWebServiceRequestAdaptable: AnyObject {
    func fetch<ParametersType: Codable>(request: GenericWebServiceRequestable,
                               parameters: ParametersType) -> AnyPublisher<DataResponse<Data, AFError>, Never>?
}
