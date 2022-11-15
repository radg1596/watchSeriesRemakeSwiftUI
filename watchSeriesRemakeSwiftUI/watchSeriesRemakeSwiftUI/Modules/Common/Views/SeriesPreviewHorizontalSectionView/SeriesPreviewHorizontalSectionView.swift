//
//  SeriesPreviewHorizontalSectionView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 13/11/22.
//

import SwiftUI

struct SeriesPreviewHorizontalSectionView: View {

    // MARK: - PROPERTIES
    private let section: SerieInformationSectionDTO
    private let totalHeigth: CGFloat
    private let totalWidth: CGFloat

    // MARK: - INIT
    init(section: SerieInformationSectionDTO,
         totalHeigth: CGFloat,
         totalWidth: CGFloat) {
        self.section = section
        self.totalHeigth = totalHeigth
        self.totalWidth = totalHeigth
    }

    // MARK: - BODY
    var body: some View {
        Section {
            ScrollView(.horizontal) {
                let itemsForHorizontal = [ GridItem(.flexible()) ]
                LazyHGrid(rows: itemsForHorizontal) {
                    ForEach(section.items) { serieItem in
                        let constants = SeriesPreviewItemViewConstants()
                        let heightForItem = constants.frameHeightFactor * totalHeigth
                        let widthForItem = constants.frameWidthFactor * totalWidth
                        SeriesPreviewItemView(item: serieItem)
                            .frame(height: heightForItem)
                            .frame(width: widthForItem)
                    }
                }
            }
        } header: {
            HStack {
                Text(section.name)
                    .font(.title2)
                    .foregroundColor(.textPrimaryColor)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.leading)
        }
    }

}

struct SeriesPreviewHorizontalScrollView_Previews: PreviewProvider {

    static var previews: some View {
        GeometryReader { geometryProxy in
            SeriesPreviewHorizontalSectionView(section: .example,
                                               totalHeigth: geometryProxy.size.height,
                                               totalWidth: geometryProxy.size.width)
        }
    }

}
