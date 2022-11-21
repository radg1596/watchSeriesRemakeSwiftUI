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
            NativeNavigationBarView(isTranslucent: true) {
                VStack {
                    if viewModel.isLoadingInitialContent {
                        loadingView
                    } else if viewModel.isShowingLoadingContentErrorView {
                        errorView
                    } else {
                        listOfListsView
                    }
                }
                .showNoInternetConnection(
                    isPresented: $viewModel.isShowingNoInternetConnectionModal,
                    retryCompletion: {
                        self.viewModel.handleErrorRetryAction()
                    })
                .background(
                    Color.principalBackgroundColor
                        .edgesIgnoringSafeArea([.bottom, .top]))
            }
            .customNavigationBarTitle(Localizables.navigationTitle.localize)
            .customNavigationBarLeftBarButton(
                .image(type:
                        .customImage(image: Image(constants.seriesIconName))))
        }
        .onAppear {
            viewModel.fetchInitialSeriesPage()
        }
    }

    // MARK: - COMPONENTS
    var loadingView: some View {
        SeriesPrincipalLandingLoadingView()
    }

    var errorView: some View {
        let errorMessage = SeriesGeneralLocalizableStrings
            .generalErrorConnectionToServer.localize
        let retryText = SeriesGeneralLocalizableStrings
            .generalErrorRetryMessageButton.localize
        return SeriesGeneralErrorAndRetryView(errorMessageText: errorMessage,
                                              errorRetryButtonText: retryText) {
            self.viewModel.handleErrorRetryAction()
        }
    }

    var listOfListsView: some View {
        GeometryReader { geometryProxy in
            ScrollView() {
                let columnsForVertical = [GridItem(.flexible()) ]
                LazyVGrid(columns: columnsForVertical,
                          spacing: constants.vGridSpacing) {
                    ForEach(viewModel.seriesSections, id: \.id) { section in
                        viewModel.cardsFactory.getItemFor(item: section,
                                                          proxy: geometryProxy)
                    }
                    Color.clear
                        .onAppear {
                            viewModel.fetchNextSeriesPage()
                        }
                }
                if viewModel.isLoadingTheNextPageOfContent {
                    LoadingNextPaginationView()
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
