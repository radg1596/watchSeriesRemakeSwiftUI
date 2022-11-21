//
//  SerieSectionsInformationUseCase.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 13/11/22.
//

import Combine
import SwiftUI

class SerieSectionsInformationUseCase: SerieSectionsInformationDataSource {

    // MARK: - PROPERTIES
    private let requestObjectDTO = SeriesInformationRequestDTO()
    private typealias LocalizableStrings = SeriesGeneralLocalizableStrings

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
    func requestToFetchInitialData() -> AnyPublisher<[SeriesLandingItemProtocol], Error> {
        let parameters = GetAllSeriesParameters(page: "\(requestObjectDTO.currentPage)")
        let publisherForGetSeries = webServiceForGetSeries.fetchModel(parameters: parameters)
        return publisherForGetSeries
            .map({ self.map(dboResponse: $0) })
            .mapError({ return $0 as Error })
            .eraseToAnyPublisher()
    }

    func requestToFetchMoreSeriesPages() -> AnyPublisher<[SeriesLandingItemProtocol], Error> {
        requestObjectDTO.currentPage += .one
        let parameters = GetAllSeriesParameters(page: "\(requestObjectDTO.currentPage)")
        let publisherForGetSeries = webServiceForGetSeries.fetchModel(parameters: parameters)
        return publisherForGetSeries
            .map({ self.map(dboResponse: $0) })
            .mapError({ [weak self] someError in
                self?.requestObjectDTO.currentPage -= .one
                return someError as Error
            })
            .eraseToAnyPublisher()
    }

    // MARK: - OWN METHODS
    private func map(dboResponse: [GetAllSeriesServiceResponseItem]) -> [SeriesLandingItemProtocol] {
        var sectionsDTO = [SeriesLandingItemProtocol]()
        var dboResponseMutable = dboResponse
        if requestObjectDTO.currentPage == .zero {
            let randonNumber = Int.random(in: .zero...dboResponse.count - .one)
            let firstItemDTO = dboResponseMutable.remove(at: randonNumber)
            sectionsDTO.append(SerieInformationMainItemDTO(from: firstItemDTO))
        }
        let dictionaryOfSections = convertToSectionsDBO(inputResponse: dboResponseMutable)
        for dictionarySection in dictionaryOfSections {
            let sectionName = "\(LocalizableStrings.generalTextPageDescription.localize) \(requestObjectDTO.currentPage + .one) \(LocalizableStrings.generalTextPageSeparator.localize) \(dictionarySection.key)"
            let newSection = SerieInformationSectionDTO(name: sectionName,
                                                     items: dictionarySection.value)
            sectionsDTO.append(newSection)
        }
        let sortedSectionsDTO = Array(sectionsDTO.sorted(by: { $0.sortString < $1.sortString }))
        return sortedSectionsDTO
    }

    private func mapFirst(dboResponse: GetAllSeriesServiceResponseItem) -> SerieInformationMainItemDTO {
        return SerieInformationMainItemDTO(from: dboResponse)
    }

    // MARK: - UTIL PARSE
    private func convertToSectionsDBO(inputResponse: [GetAllSeriesServiceResponseItem]) -> [String : [SerieInformationItemDTO]] {
        var dictionaryOfSections = [String: [SerieInformationItemDTO]]()
        for itemDbo in inputResponse {
            guard let genreOfItem = itemDbo.genres.first else { continue }
            if dictionaryOfSections[genreOfItem] != nil {
                dictionaryOfSections[genreOfItem]?.append(SerieInformationItemDTO(from: itemDbo))
            } else {
                dictionaryOfSections[genreOfItem] = [SerieInformationItemDTO(from: itemDbo)]
            }
        }
        return dictionaryOfSections
    }

}
