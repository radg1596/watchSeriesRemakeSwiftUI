//
//  SeriesMainItemPreviewViewConstants.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 20/11/22.
//

import Foundation

final class SeriesMainItemPreviewViewConstants {

    // MARK: - COMMON
    let navBarHeight: CGFloat = 44.0

    // MARK: - UI V-STACK
    lazy var vStackYOffset: CGFloat = { -navBarHeight }()
    let vStackZIndex: CGFloat = 1

    // MARK: - UI Z-STACK
    let zStackHeightFactor: CGFloat = 0.9

    // MARK: -ASYNC IMAGE
    let asyncImageHeightFactor: CGFloat = 0.9
    lazy var asyncImagePlusForHeight: CGFloat = { navBarHeight + 30.0 }()
    lazy var asyncImageYOffset: CGFloat = { -navBarHeight }()

    // MARK: - RECTANGLE
    let rectangleColorOpacity: CGFloat = 0.25
    let rectangleFrameHeight: CGFloat = 130.0
    let rectangleWidhtFactor: CGFloat = 1.5
    let rectangleBlurRadius: CGFloat = 20.0

    // MARK: - IMAGES NAMES
    let leftButtonImageName: String = "plus"
    let middleButtonImageName: String = "play.fill"
    let righButtonImageName: String = "info"

}
