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
        AsyncImageCache(urlString: item.image.medium,
                        cachePolicy: .returnCacheDataElseLoad) { phase in
            switch phase {
            case .empty:
                SkeletonViewBase()
            case .success(let image):
                image
                    .resizable()
            case .failure:
                Text(item.name)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.secondaryBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: constants.cornerRadiusForView))
    }

}


struct SeriesPreviewItemView_Previews: PreviewProvider {

    static var previews: some View {
        SeriesPreviewItemView(item: SerieInformationItemDTO.example)
    }

}
