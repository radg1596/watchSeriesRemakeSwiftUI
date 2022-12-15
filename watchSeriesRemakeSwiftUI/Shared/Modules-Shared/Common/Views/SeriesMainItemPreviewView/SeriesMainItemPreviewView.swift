//
//  SeriesMainItemPreviewView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 17/11/22.
//

import SwiftUI

struct SeriesMainItemPreviewView: View {

    // MARK: - STATE PROPERTIES
    @State private var isLoadingContent: Bool = true

    // MARK: - PROPERTIES
    private let constants = SeriesMainItemPreviewViewConstants()
    private typealias Localizables = SeriesGeneralLocalizableStrings
    private let item: SerieInformationItemDTO
    private let totalHeight: CGFloat
    private let totalWidht: CGFloat

    // MARK: - INIT
    init(item: SerieInformationItemDTO,
         totalHeight: CGFloat,
         totalWidht: CGFloat) {
        self.item = item
        self.totalHeight = totalHeight
        self.totalWidht = totalWidht
    }

    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            imageSectionView
            VStack {
                tagsSectionView
                if !isLoadingContent {
                    buttonsActionSectionView
                        .padding([.leading, .trailing])
                }
            }
            .offset(y: constants.vStackYOffset)
            .zIndex(constants.vStackZIndex)
            rectangleSectionGradient
       }
        .frame(width: totalWidht)
        .frame(height: totalHeight * constants.zStackHeightFactor)
    }

    // MARK: - VIEWS
    var imageSectionView: some View {
        AsyncImageCache(urlString: item.image.original,
                        cachePolicy: .returnCacheDataElseLoad,
                        content: { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(
                        CircularProgressViewStyle(tint: .textPrimaryColor))
            case .failure:
                Color.clear
            case .success(let image):
                image
                    .resizable()
                    .frame(width: totalWidht)
                    .frame(height: totalHeight * constants.zStackHeightFactor + constants.asyncImagePlusForHeight)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Rectangle())
                    .offset(y: constants.asyncImageYOffset)
            }
        }, onFinishCompletion: {
            isLoadingContent = false
        })
    }

    var tagsSectionView: some View {
        Text(item.genresDescription)
            .font(.title3)
            .bold()
            .multilineTextAlignment(.center)
            .foregroundColor(Color.textPrimaryColor)
            .frame(width: totalWidht)
    }

    var buttonsActionSectionView: some View {
        SeriesTripleActionBarView(leftButtonTitle: titleForLeadingButton,
                                  leftButtonSysImageName: constants.leftButtonImageName,
                                  onClickLeftButton: {
            // Action here...
        },
                                  middleButtonTitle: titleForCenterButton,
                                  middleButtonSysImageName: constants.middleButtonImageName,
                                  onClickMiddleButton: {
            // Action here...
        },
                                  rightButtonTitle: titleForTrailingButton,
                                  rightButtonSysImageName: constants.righButtonImageName) {
            // Action here...
        }
    }

    var rectangleSectionGradient: some View {
        Rectangle()
            .fill(
                LinearGradient(colors: [ .clear,
                                         .principalBackgroundColor.opacity(constants.rectangleColorOpacity),
                                         .principalBackgroundColor,
                                         .principalBackgroundColor,
                                         .principalBackgroundColor,
                                         .principalBackgroundColor,
                                         .principalBackgroundColor],
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .frame(height: constants.rectangleFrameHeight)
            .frame(width: totalWidht * constants.rectangleWidhtFactor)
            .blur(radius: constants.rectangleBlurRadius)
    }

    // MARK: - BUTTON TITLES
    private var titleForLeadingButton: String {
        #if os(watchOS)
        return String()
        #else
        return Localizables.generalTextMyList.localize
        #endif
    }

    private var titleForCenterButton: String {
    #if os(watchOS)
        return String()
    #else
        return Localizables.generalTextPlayText.localize
    #endif
    }

    private var titleForTrailingButton: String {
    #if os(watchOS)
        return String()
    #else
        return Localizables.generalTextInfoText.localize
    #endif
    }

}

struct SeriesMainItemPreviewView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            GeometryReader { geometryProxy in
                ScrollView {
                    SeriesMainItemPreviewView(item: .example,
                                              totalHeight: geometryProxy.size.height,
                                              totalWidht: geometryProxy.size.width)
                }
            }
        }
    }

}
