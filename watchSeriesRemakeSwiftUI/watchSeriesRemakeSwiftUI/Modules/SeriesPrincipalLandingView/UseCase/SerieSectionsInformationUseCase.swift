//
//  SerieSectionsInformationUseCase.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 13/11/22.
//

import Combine
import SwiftUI

class SerieSectionsInformationUseCase {

    // MARK: - PROPERTIES
    private let requestObjectDTO = SeriesInformationRequestDTO()

    // MARK: - SERVICE
    private lazy var webServiceForGetSeries: GenericWebServiceManager<[GetAllSeriesServiceResponseItem],
                                                                      GenericWebServiceGenericErrorModel> = {
      let requestObjectForService = GetAllSeriesServiceRequest()
      let service = GenericWebServiceManager<[GetAllSeriesServiceResponseItem],
                                             GenericWebServiceGenericErrorModel>(request: requestObjectForService)
      return service
    }()

    // MARK: - INIT
    init() {
    }

    // MARK: - METHODS
    func requestToFetchInitialSeriesPage() -> AnyPublisher<[SerieInformationSectionDTO], Error> {
        let parameters = GetAllSeriesParameters(page: "\(requestObjectDTO.currentPage)")
        let publisherForGetSeries = webServiceForGetSeries.fetchModel(parameters: parameters)
        return publisherForGetSeries
            .map(map(dboResponse:))
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }

    func requestToFetchMoreSeriesPages() -> AnyPublisher<[SerieInformationSectionDTO], Error> {
        requestObjectDTO.currentPage += .one
        let parameters = GetAllSeriesParameters(page: "\(requestObjectDTO.currentPage)")
        let publisherForGetSeries = webServiceForGetSeries.fetchModel(parameters: parameters)
        return publisherForGetSeries
            .map(map(dboResponse:))
            .mapError({ [weak self] someError in
                self?.requestObjectDTO.currentPage -= .one
                return someError as Error
            })
            .eraseToAnyPublisher()
    }

    // MARK: - OWN METHODS
    func map(dboResponse: [GetAllSeriesServiceResponseItem]) -> [SerieInformationSectionDTO] {
        var sectionsDTO: [SerieInformationSectionDTO] = []
        let dboSections = convertToSectionsDBO(inputResponse: dboResponse)
        for sectionDbo in dboSections {
            let newItemsDTO = sectionDbo.map({SerieInformationItemDTO(from: $0)})
            let newSectionDTO = SerieInformationSectionDTO(name: "SECTION",
                                                           items: newItemsDTO)
            sectionsDTO.append(newSectionDTO)
        }
        return sectionsDTO
    }

    private func convertToSectionsDBO(inputResponse: [GetAllSeriesServiceResponseItem]) -> [[GetAllSeriesServiceResponseItem]] {
        return inputResponse.chunked(into: 20)
    }


}
