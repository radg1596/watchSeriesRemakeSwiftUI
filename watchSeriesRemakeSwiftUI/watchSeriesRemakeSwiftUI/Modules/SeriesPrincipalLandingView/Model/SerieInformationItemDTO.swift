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

    // MARK: - INIT
    init(from dbo: GetAllSeriesServiceResponseItem) {
        self.id = dbo.id
        self.name = dbo.name
        self.url = dbo.url
        self.image = SerieInformationItemImagesDTO(medium: dbo.image.medium,
                                                   original: dbo.image.original)
    }

    init(id: Int, name: String, url: String, image: SerieInformationItemImagesDTO) {
        self.id = id
        self.name = name
        self.url = url
        self.image = image
    }

}

final class SerieInformationItemImagesDTO {

    let medium: String
    let original: String

    // MARK: - INIT
    init(medium: String, original: String) {
        self.medium = medium
        self.original = original
    }
}

extension SerieInformationItemDTO {

    static var example: SerieInformationItemDTO {
        let imageDTO =
        SerieInformationItemImagesDTO(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/424/1061900.jpg",
                                      original:"https://static.tvmaze.com/uploads/images/original_untouched/424/1061900.jpg")
        return SerieInformationItemDTO(id: 73,
                                       name: "The Walking Dead",
                                       url: "https://www.tvmaze.com/shows/73/the-walking-dead",
                                       image: imageDTO)
    }

}
