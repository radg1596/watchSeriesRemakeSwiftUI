//
//  SeriesPrincipalLandingView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import SwiftUI

struct SeriesPrincipalLandingView: View {

    // MARK: - VIEW MODEL
    @StateObject private var viewModel: ViewModel = ViewModel()

    // MARK: - PROPERTIES
    private let constants = SeriesPrincipalLandingViewConstants()
    private typealias Localizables = SeriesPrincipalLandingLocalizables

    // MARK: - VIEW
    var body: some View {
        NavigationView {
            NativeNavigationBarView() {
                VStack {
                    if viewModel.isLoadingInitialContent {
                        loadingView
                    } else if viewModel.isShowingLoadingContentErrorView {
                        errorView
                    } else {
                        listOfListsView
                    }
                }
                .background(
                    Color.principalBackgroundColor
                        .edgesIgnoringSafeArea(.bottom))
            }
            .customNavigationBarTitle(Localizables.navigationTitle.localize)
        }
        .onAppear {
            viewModel.fetchInitialSeriesPage()
        }
    }

    // MARK: - COMPONENTS
    var loadingView: some View {
        ProgressView()
    }

    var errorView: some View {
        Text("Error!")
    }

    var listOfListsView: some View {
        GeometryReader { geometryProxy in
            ScrollView() {
                let columnsForVertical = [GridItem(.flexible()) ]
                LazyVGrid(columns: columnsForVertical,
                          spacing: constants.vGridSpacing) {
                    ForEach(viewModel.seriesSections) { section in
                        let height = geometryProxy.size.height
                        let width = geometryProxy.size.width
                        SeriesPreviewHorizontalSectionView(section: section,
                                                           totalHeigth: height,
                                                           totalWidth: width)
                    }
                    Color.clear
                        .onAppear {
                            viewModel.fetchNextSeriesPage()
                        }
                }
                if viewModel.isLoadingTheNextPageOfContent {
                    VStack {
                        ProgressView()
                            .foregroundColor(.textPrimaryColor)
                    }
                }
            }
        }
    }

}

struct SeriesPrincipalLandingView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            SeriesPrincipalLandingView()
        }
    }

}
