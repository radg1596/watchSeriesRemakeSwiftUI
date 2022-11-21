//
//  SerieSectionsInformationDataSource.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 13/11/22.
//

import Combine

protocol SerieSectionsInformationDataSource {
    func requestToFetchInitialData() -> AnyPublisher<[SeriesLandingItemProtocol], Error>
    func requestToFetchMoreSeriesPages() -> AnyPublisher<[SeriesLandingItemProtocol], Error>
}
