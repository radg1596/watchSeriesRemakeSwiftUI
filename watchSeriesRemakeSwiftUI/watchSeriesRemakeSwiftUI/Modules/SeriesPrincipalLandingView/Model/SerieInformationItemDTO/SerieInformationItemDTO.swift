//
//  SerieInformationItemDTO.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Foundation

class SerieInformationItemDTO: Identifiable {

    // MARK: - PROPERTIES
    let id: Int
    let name: String
    let url: String
    let image: SerieInformationItemImagesDTO
    let genres: [SerieInformationItemGenreDTO]

    // MARK: - INIT
    init(from dbo: GetAllSeriesServiceResponseItem) {
        self.id = dbo.id
        self.name = dbo.name
        self.url = dbo.url
        self.image = SerieInformationItemImagesDTO(medium: dbo.image?.medium,
                                                   original: dbo.image?.original)
        self.genres = dbo.genres.map({ SerieInformationItemGenreDTO(rawValue: $0) ?? .unknown})
    }

    init(id: Int, name: String, url: String,
         image: SerieInformationItemImagesDTO,
         genres: [SerieInformationItemGenreDTO]) {
        self.id = id
        self.name = name
        self.url = url
        self.image = image
        self.genres = genres
    }

}