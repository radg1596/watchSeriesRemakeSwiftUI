//
//  GetAllSeriesParameters.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 12/11/22.
//

import Foundation

class GetAllSeriesParameters: Codable {

    // MARK: - INIT
    let page: String

    // MARK: - INIT
    init(page: String) {
        self.page = page
    }

}
