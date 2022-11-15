//
//  SerieInformationItemDTO+Preview.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 12/11/22.
//

import Foundation

extension SerieInformationItemDTO {

    static var example: SerieInformationItemDTO {
        let imageDTO =
        SerieInformationItemImagesDTO(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/424/1061900.jpg",
                                      original:"https://static.tvmaze.com/uploads/images/original_untouched/424/1061900.jpg")
        return SerieInformationItemDTO(id: 73,
                                       name: "The Walking Dead",
                                       url: "https://www.tvmaze.com/shows/73/the-walking-dead",
                                       image: imageDTO,
                                       genres: [.horror, .scienceFiction])
    }

}
