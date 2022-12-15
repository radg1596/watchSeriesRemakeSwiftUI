//
//  SeriesPrincipalLandingViewModel.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Foundation
import Combine

extension SeriesPrincipalLandingView {

    @MainActor class ViewModel<LandingFactoryType: SeriesPrincipalLandingFactoryProtocol>: ObservableObject {

        // MARK: - OWN PROPERTIES
        private let seriesDataSource: SerieSectionsInformationDataSource
        private let connectionChecker: InternetConnectionCheckeable
        private let cardsFactoryInternal: LandingFactoryType
        private var cancelablesItems = Set<AnyCancellable>()

        // MARK: - FACTORY ACCESS
        var cardsFactory: some SeriesPrincipalLandingFactoryProtocol {
            return cardsFactoryInternal
        }

        // MARK: - PROPERTIES FOR PUBLISH
        @Published var seriesSections: [SeriesLandingItemProtocol] = []
        @Published var isShowingNoInternetConnectionModal: Bool = false
        @Published var isShowingLoadingContentErrorView: Bool = false
        @Published var isLoadingInitialContent: Bool = true
        @Published var isLoadingTheNextPageOfContent: Bool = false
    
        // MARK: - INIT
        init(seriesDataSource: SerieSectionsInformationDataSource = SerieSectionsInformationUseCase(),
             connectionChecker: InternetConnectionCheckeable = InternetConnectionCheckerManager(),
             cardsFactoryInternal: LandingFactoryType = SeriesPrincipalLandingFactory()) {
            self.seriesDataSource = seriesDataSource
            self.connectionChecker = connectionChecker
            self.cardsFactoryInternal = cardsFactoryInternal
        }
    
        // MARK: - METHODS
        func fetchInitialSeriesPage() {
            isLoadingInitialContent = true
            seriesDataSource.requestToFetchInitialData()
                .sink { [weak self] completion in
                    self?.isLoadingInitialContent = false
                    switch completion {
                    case .failure:
                        self?.isShowingLoadingContentErrorView = true
                    case .finished:
                        break
                    }
                } receiveValue: { [weak self] newSections in
                    self?.isLoadingInitialContent = false
                    self?.isShowingLoadingContentErrorView = false
                    self?.seriesSections.append(contentsOf: newSections)
                }
                .store(in: &cancelablesItems)
        }

        func handleErrorRetryAction() {
            connectionChecker.networkCheckerPublisher()
                .sink { [weak self] isAvailable in
                    guard let self = self else { return }
                    if isAvailable {
                        self.fetchInitialSeriesPage()
                    } else {
                        self.isShowingNoInternetConnectionModal = true
                    }
                }
                .store(in: &cancelablesItems)
        }

        func fetchNextSeriesPage() {
            guard isLoadingInitialContent == false else { return }
            isLoadingTheNextPageOfContent = true
            seriesDataSource.requestToFetchMoreSeriesPages()
                .sink { [weak self] completion in
                    switch completion {
                    case .failure:
                        self?.isLoadingTheNextPageOfContent = false
                    default:
                        break
                    }
                } receiveValue: { [weak self] newSections in
                    self?.isLoadingTheNextPageOfContent = false
                    self?.seriesSections.append(contentsOf: newSections)
                }
                .store(in: &cancelablesItems)
        }

    }

}
