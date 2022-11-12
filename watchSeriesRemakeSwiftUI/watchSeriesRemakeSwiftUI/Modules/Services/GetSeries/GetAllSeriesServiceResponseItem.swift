//
//  GetAllSeriesServiceResponseItem.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Foundation

class GetAllSeriesServiceResponseItem: Codable {

    let id: Int
    let name: String
    let url: String
    let image: GetAllSeriesServiceResponseItemImage

}

class GetAllSeriesServiceResponseItemImage: Codable {

    let medium: String
    let original: String

}
