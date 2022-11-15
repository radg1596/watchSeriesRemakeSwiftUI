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
    func requestToFetchInitialData() -> AnyPublisher<[SerieInformationSectionDTO], Error> {
        let parameters = GetAllSeriesParameters(page: "\(requestObjectDTO.currentPage)")
        let publisherForGetSeries = webServiceForGetSeries.fetchModel(parameters: parameters)
        return publisherForGetSeries
            .map({ self.map(dboResponse: $0) })
            .mapError({ return $0 as Error })
            .eraseToAnyPublisher()
    }

    func requestToFetchMoreSeriesPages() -> AnyPublisher<[SerieInformationSectionDTO], Error> {
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
    func map(dboResponse: [GetAllSeriesServiceResponseItem]) -> [SerieInformationSectionDTO] {
        var sectionsDTO = [SerieInformationSectionDTO]()
        for (index, section) in dboResponse.chunked(into: 20).enumerated() {
            let itemsForSection = section.map({SerieInformationItemDTO(from: $0)})
            let nameForSection = "Página \(requestObjectDTO.currentPage + .one) - (Sección. \(index + .one))"
            let sectionDTO = SerieInformationSectionDTO(name: nameForSection,
                                                        items: itemsForSection)
            sectionsDTO.append(sectionDTO)
        }
        return sectionsDTO
    }

//    private func convertToSectionsDBO(inputResponse: [GetAllSeriesServiceResponseItem],
//                                      currentSections: [SerieInformationSectionDTO]) -> [String : [SerieInformationItemDTO]] {
//        var dictionaryOfSections = mapCurrentSectionsToDictionary(currentSections: currentSections)
//        for itemDbo in inputResponse {
//            guard let genreOfItem = itemDbo.genres.first else { continue }
//            if dictionaryOfSections[genreOfItem] != nil {
//                dictionaryOfSections[genreOfItem]?.append(SerieInformationItemDTO(from: itemDbo))
//            } else {
//                dictionaryOfSections[genreOfItem] = [SerieInformationItemDTO(from: itemDbo)]
//            }
//        }
//        return dictionaryOfSections
//    }
//
//    private func mapCurrentSectionsToDictionary(currentSections: [SerieInformationSectionDTO]) -> [String: [SerieInformationItemDTO]] {
//        var finalDictionary = [String: [SerieInformationItemDTO]]()
//        for section in currentSections {
//            if finalDictionary[section.name] == nil {
//                finalDictionary[section.name] = section.items
//            }
//        }
//        return finalDictionary
//    }


}
