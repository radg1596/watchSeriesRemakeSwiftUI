//
//  SeriesInformationSectionDTO.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 12/11/22.
//

import Foundation

final class SerieInformationSectionDTO: Identifiable {

    // MARK: - PROPERTIES
    let id: String = UUID().uuidString
    let name: String
    let items: [SerieInformationItemDTO]

    // MARK: - INIT
    init(name: String, items: [SerieInformationItemDTO]) {
        self.name = name
        self.items = items
    }

    // MARK: - PREVIEW
    static var example: SerieInformationSectionDTO {
        SerieInformationSectionDTO(name: "Example", items: [.example])
    }

}
