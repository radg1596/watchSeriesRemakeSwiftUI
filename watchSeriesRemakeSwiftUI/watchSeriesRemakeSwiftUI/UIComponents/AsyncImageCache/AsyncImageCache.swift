//
//  AsyncImageCache.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI
import Combine

struct AsyncImageCache<Content: View>: View {

    // MARK: - OBSERVABLE PROPERTIES
    @State private var currentContentPhase: AsyncImageCachePhase = .empty

    // MARK: - PROPERTIES
    private let urlString: String?
    private let cachePolicy: NSURLRequest.CachePolicy
    private var imageDownloader: ImageRemoteDataSourceProtocol
    private var content: (AsyncImageCachePhase) -> Content

    // MARK: - ERROR
    enum InternalError: Error {
        case nilUrl
    }

    // MARK: - INIT
    init(urlString: String?,
         imageDownloader: ImageRemoteDataSourceProtocol = ImageDownloaderManager(),
         cachePolicy: NSURLRequest.CachePolicy,
         @ViewBuilder content: @escaping  (AsyncImageCachePhase) -> Content) {
        self.urlString = urlString
        self.cachePolicy = cachePolicy
        self.imageDownloader = imageDownloader
        self.content = content
    }

    // MARK: - BODY
    var body: some View {
        switch currentContentPhase {
        case .empty:
            VStack {
                Spacer()
                content(.empty)
                Spacer()
            }
            .onAppear {
                onAppearExecute()
            }
        case .success(let image):
            content(.success(image: image))
            .onAppear {
                onAppearExecute()
            }
        case .failure(let error):
            content(.failure(error: error))
                .onAppear {
                    onAppearExecute()
                }
        }
    }

    // MARK: - OWN METHODS
    private func onAppearExecute() {
        guard let urlString = urlString else {
            currentContentPhase = .failure(error: InternalError.nilUrl)
            return
        }
        imageDownloader.requestToFetchImage(urlString, cachePolicy: cachePolicy)
            .sink { result in
                switch result {
                case .failure(let error):
                    currentContentPhase = .failure(error: error)
                case .finished:
                    return
                }
            } receiveValue: { image in
                currentContentPhase = .success(image: Image(uiImage: image))
            }
            .store(in: &ImageDownloaderManager.setOfCancelables)
    }

}
