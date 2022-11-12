//
//  ImageRemoteDataSourceProtocol.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import Combine
import UIKit

protocol ImageRemoteDataSourceProtocol {
    func requestToFetchImage(_ fromUrl: String, cachePolicy: NSURLRequest.CachePolicy) -> AnyPublisher<UIImage, Error>
}
