//
//  GetAllSeriesServiceRequest.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Foundation
import Alamofire
import GenericNetworkingLayer

final class GetAllSeriesServiceRequest: GenericWebServiceRequestable {

    // MARK: - REQUEST PROPERTIES
    var baseUrl: String { "https://api.tvmaze.com" }
    var endPointPath: String { "/shows" }
    var method: Alamofire.HTTPMethod { .get }
    var headers: Alamofire.HTTPHeaders { HTTPHeaders() }
    var timeOut: Double { 30 }
    var queryItems: [URLQueryItem]? {
        return []
    }

}
