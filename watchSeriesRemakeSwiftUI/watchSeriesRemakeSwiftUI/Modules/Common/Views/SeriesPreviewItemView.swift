//
//  SeriesPreviewItemView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 09/11/22.
//

import SwiftUI

struct SeriesPreviewItemView: View {

    // MARK: - ITEM
    private let item: SerieInformationItemDTO
    private let constants = SeriesPreviewItemViewConstants()

    // MARK: - INIT
    init(item: SerieInformationItemDTO) {
        self.item = item
    }

    // MARK: - VIEW
    var body: some View {
        ZStack {
            AsyncImageCache(urlString: item.image.medium, cachePolicy: .returnCacheDataElseLoad) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                case .failure:
                    Text(item.name)
                }
            }
        }
        .frame(height: constants.frameHeightDefault)
        .background(Color.principalBackgroundColor)
    }

}

// MARK: - CONSTANTS CLASS
fileprivate struct SeriesPreviewItemViewConstants {

    /// Default height for the item
    let frameHeightDefault: CGFloat = 250

}

struct SeriesPreviewItemView_Previews: PreviewProvider {

    static var previews: some View {
        SeriesPreviewItemView(item: SerieInformationItemDTO.example)
    }

}
