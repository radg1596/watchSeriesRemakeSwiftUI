//
//  SeriesPrincipalLandingViewModel.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Foundation
import Combine

extension SeriesPrincipalLandingView {

    @MainActor class ViewModel: ObservableObject {

        // MARK: - OWN PROPERTIES
        private let seriesDataSource: SerieSectionsInformationDataSource
        private var cancelablesItems = Set<AnyCancellable>()

        // MARK: - PROPERTIES FOR PUBLISH
        @Published private(set) var seriesSections: [SerieInformationSectionDTO] = [SerieInformationSectionDTO]()
        @Published private(set) var isShowingLoadingContentErrorView: Bool = false
        @Published private(set) var isLoadingInitialContent: Bool = false
        @Published private(set) var isLoadingTheNextPageOfContent: Bool = false
    
        // MARK: - INIT
        init(seriesDataSource: SerieSectionsInformationDataSource = SerieSectionsInformationUseCase()) {
            self.seriesDataSource = seriesDataSource
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

        func fetchNextSeriesPage() {
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
