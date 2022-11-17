//
//  SeriesPrincipalLandingLoadingView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 15/11/22.
//

import SwiftUI

struct SeriesPrincipalLandingLoadingView: View {

    // MARK: - PROPERTIES
    private let constants = SeriesPrincipalLandingLoadingViewConstants()

    // MARK: - BODY
    var body: some View {
        GeometryReader { geometryProxy in
            let totalHeight = geometryProxy.size.height
            VStack {
                Spacer()
                VStack {
                    topLoadingView
                    middleLoadingView
                    bottomLoadingView
                }
                .frame(height: totalHeight * constants.totalViewHeightFactor)
            }
            .background(Color.principalBackgroundColor)
        }
    }

    // MARK: - VIEWS
    var topLoadingView: some View {
        GeometryReader { geometryProxy in
            let totalHeight = geometryProxy.size.height
            let totalWidth = geometryProxy.size.width
            HStack {
                Spacer()
                SkeletonViewBase()
                    .frame(height: totalHeight * constants.topLoadingViewHeightFactor)
                    .frame(width: totalWidth * constants.topLoadingViewWidhtFactor)
                Spacer()
            }
        }
    }

    var middleLoadingView: some View {
        GeometryReader { geometryProxy in
            let totalHeight = geometryProxy.size.height
            let totalWidth = geometryProxy.size.width
            HStack {
                Spacer()
                SkeletonViewBase()
                    .frame(height: totalHeight * constants.middleLoadingViewHeightFactor)
                    .frame(width: totalWidth * constants.middleLoadingViewWidhtFactor)
                Spacer()
            }
        }
    }

    var bottomLoadingView: some View {
        GeometryReader { geometryProxy in
            let totalHeight = geometryProxy.size.height
            let totalWidth = geometryProxy.size.width
            HStack {
                Spacer()
                SkeletonViewBase()
                    .frame(height: totalHeight * constants.bottomLoadingViewHeightFactor)
                    .frame(width: totalWidth * constants.bottomLoadingViewWidhtFactor)
                Spacer()
            }
        }
    }

}

struct SeriesPrincipalLandingLoadingView_Previews: PreviewProvider {

    static var previews: some View {
        SeriesPrincipalLandingLoadingView()
    }

}
