//
//  SeriesPrincipalLandingFactory.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 17/11/22.
//

import SwiftUI

class SeriesPrincipalLandingFactory: SeriesPrincipalLandingFactoryProtocol {

    // MARK: - CONSTANTS
    private let constants = SeriesPrincipalLandingViewConstants()

    // MARK: - METHODS
    @ViewBuilder func getItemFor(item: SeriesLandingItemProtocol, proxy: GeometryProxy) -> some View {
        switch item {
        case (let item as SerieInformationSectionDTO):
            let height = proxy.size.height
            let width = proxy.size.width
            SeriesPreviewHorizontalSectionView(section: item,
                                                      totalHeigth: height,
                                                      totalWidth: width)
        case (let item as SerieInformationMainItemDTO):
            let height = proxy.size.height
            let width = proxy.size.width
            VStack {
                SeriesMainItemPreviewView(item: item,
                                          totalHeight: height,
                                          totalWidht: width)
            }
        default:
            Color.clear
        }
    }

}
