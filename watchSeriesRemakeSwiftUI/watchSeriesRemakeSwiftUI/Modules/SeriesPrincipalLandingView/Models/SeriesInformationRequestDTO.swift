//
//  SeriesInformationRequestDTO.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 12/11/22.
//

import Foundation

class SeriesInformationRequestDTO {

    // MARK: - PROPERTIES
    var currentPage: Int

    // MARK: - INIT
    init(currentPage: Int = .zero) {
        self.currentPage = currentPage
    }

}
