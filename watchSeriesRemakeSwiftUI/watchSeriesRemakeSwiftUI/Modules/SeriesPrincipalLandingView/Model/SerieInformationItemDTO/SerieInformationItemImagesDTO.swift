//
//  SerieInformationItemImagesDTO.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 12/11/22.
//

import Foundation

final class SerieInformationItemImagesDTO {

    let medium: String?
    let original: String?

    // MARK: - INIT
    init(medium: String?, original: String?) {
        self.medium = medium
        self.original = original
    }
}
