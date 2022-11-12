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

    // MARK: - PROPERTIES
    private var publisherForDownloaderImage = PassthroughSubject<UIImage, Error>()

    // MARK: - CANCELABLES
    static var setOfCancelables = Set<AnyCancellable>()

    // MARK: - ERROR
    enum ImageDownloaderManagerError: Error {
        case invalidURL
        case canNotParseDataToImage
    }

    // MARK: - METHODS
    func requestToFetchImage(_ fromUrl: String, cachePolicy: NSURLRequest.CachePolicy) -> AnyPublisher<UIImage, Error> {
        self.publisherForDownloaderImage = PassthroughSubject<UIImage, Error>()
        guard let urlForImage = URL(string: fromUrl),
              let requestForImage = URLRequest(url: urlForImage, cachePolicy: cachePolicy).urlRequest else {
            DispatchQueue.main.async {
                self.publisherForDownloaderImage.send(completion: .failure(ImageDownloaderManagerError.invalidURL))
            }
            return publisherForDownloaderImage.eraseToAnyPublisher()
        }
        requestToDownloadImage(requestForImage: requestForImage)
        return publisherForDownloaderImage.eraseToAnyPublisher()
    }

    // MARK: - OWN METHODS
    private func requestToDownloadImage(requestForImage: URLRequest) {
        let publisherFromUrlSession = URLSession.shared.dataTaskPublisher(for: requestForImage)
        publisherFromUrlSession
            .map({ [weak self] in
                self?.mapToImage(data: $0, response: $1)
            })
            .sink { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async { self.publisherForDownloaderImage.send(completion: .failure(error)) }
                case .finished:
                    DispatchQueue.main.async { self.publisherForDownloaderImage.send(completion: .finished) }
                }
            } receiveValue: { resultValue in
                switch resultValue {
                case .failure(let error):
                    DispatchQueue.main.async { self.publisherForDownloaderImage.send(completion: .failure(error)) }
                case .success(let image):
                    DispatchQueue.main.async {
                        self.publisherForDownloaderImage.send(image)
                        self.publisherForDownloaderImage.send(completion: .finished)
                    }
                case .none:
                    DispatchQueue.main.async { self.publisherForDownloaderImage.send(completion: .finished) }
                }
            }
            .store(in: &ImageDownloaderManager.setOfCancelables)
    }

    private func mapToImage(data: Data, response: URLResponse) -> Result<UIImage, Error> {
        if let uiImage = UIImage(data: data) {
            return .success(uiImage)
        } else {
            return .failure(ImageDownloaderManagerError.canNotParseDataToImage)
        }
    }

}
