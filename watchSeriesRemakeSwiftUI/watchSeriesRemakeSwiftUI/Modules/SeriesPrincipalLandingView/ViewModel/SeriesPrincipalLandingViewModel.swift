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
        private let webServiceForGetSeries = GenericWebServiceManager<[GetAllSeriesServiceResponseItem], GenericWebServiceGenericErrorModel>(request: GetAllSeriesServiceRequest())
        private var cancelablesItems = Set<AnyCancellable>()

        // MARK: - PROPERTIES FOR PUBLISH
        @Published private(set) var series: [SerieInformationItemDTO] = [SerieInformationItemDTO]()
        @Published var isShowingLoadingContentErrorView: Bool = false
        @Published var isLoadingContent: Bool = false
    
        // MARK: - METHODS
        func fetchSeries() {
            let parameters = GenericServiceEmptyParameters()
            let publisherForGetSeries = webServiceForGetSeries.fetchModel(parameters: parameters)
            self.isLoadingContent = true
            publisherForGetSeries
                .map { itemsDBO in
                    itemsDBO.map({ SerieInformationItemDTO(from: $0) }) }
                .sink { [weak self] receivedResponse in
                    switch receivedResponse {
                    case .finished:
                        break
                    case.failure:
                        self?.isLoadingContent = false
                        self?.isShowingLoadingContentErrorView = true
                    }
                } receiveValue: { [weak self] seriesItemsDTO in
                    self?.isLoadingContent = false
                    self?.isShowingLoadingContentErrorView = false
                    self?.series.append(contentsOf: seriesItemsDTO)
                }
                .store(in: &cancelablesItems)
        }

    }

}
