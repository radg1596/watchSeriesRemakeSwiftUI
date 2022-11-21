//
//  ImageDownloaderManager.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import Foundation
import UIKit
import Combine

class ImageDownloaderManager: ImageRemoteDataSourceProtocol {

    // MARK: - CANCELABLES
    static var setOfCancelables = Set<AnyCancellable>()

    // MARK: - ERROR
    enum InternalError: Error {
        case invalidURL
        case canNotParseDataToImage
    }

    // MARK: - METHODS
    func requestToFetchImage(_ fromUrl: String, cachePolicy: NSURLRequest.CachePolicy) -> AnyPublisher<UIImage, Error> {
        guard let urlForImage = URL(string: fromUrl),
              let requestForImage = URLRequest(url: urlForImage, cachePolicy: cachePolicy).urlRequest else {
            return Fail(outputType: UIImage.self, failure: InternalError.invalidURL)
                .eraseToAnyPublisher()
        }
        let publisherFromUrlSession = URLSession.shared.dataTaskPublisher(for: requestForImage)
        return publisherFromUrlSession
            .tryMap( { try self.mapToImage(data: $0, response: $1) })
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    // MARK: - OWN METHODS
    private func mapToImage(data: Data, response: URLResponse) throws -> UIImage {
        if let uiImage = UIImage(data: data) {
            return uiImage
        } else {
            throw InternalError.canNotParseDataToImage
        }
    }

}
