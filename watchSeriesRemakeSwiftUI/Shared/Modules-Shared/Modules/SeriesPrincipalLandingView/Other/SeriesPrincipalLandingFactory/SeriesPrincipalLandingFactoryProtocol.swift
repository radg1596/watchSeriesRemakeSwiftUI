//
//  SeriesPrincipalLandingFactoryProtocol.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 17/11/22.
//

import SwiftUI

protocol SeriesPrincipalLandingFactoryProtocol {
    associatedtype SomeView: View
    @ViewBuilder 
    func getItemFor(item: SeriesLandingItemProtocol, proxy: GeometryProxy) -> SomeView
}
