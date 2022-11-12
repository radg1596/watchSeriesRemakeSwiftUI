//
//  GenericWebServiceRequestable.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Alamofire
import Foundation

protocol GenericWebServiceRequestable: AnyObject {
    var baseUrl: String { get }
    var endPointPath: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var timeOut: Double { get }
    var queryItems: [URLQueryItem]? { get }
}
