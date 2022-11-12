//
//  SeriesPrincipalLandingView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import SwiftUI

struct SeriesPrincipalLandingView: View {

    // MARK: - PROPERTIES
    @StateObject var viewModel: ViewModel = ViewModel()

    // MARK: - VIEW
    var body: some View {
        NavigationView {
            NativeNavigationBarView() {
                VStack {
                    if viewModel.isLoadingContent {
                        ProgressView()
                    } else if viewModel.isShowingLoadingContentErrorView {
                        Text("Error Getting The Array!")
                    } else {
                        let columns = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 5) {
                                ForEach(viewModel.series) { serieItem in
                                    SeriesPreviewItemView(item: serieItem)
                                }
                            }
                        }
                        .background(Color.principalBackgroundColor.edgesIgnoringSafeArea(.bottom))
                    }
                }
            }
            .customNavigationBarTitle("Series")
        }
        .onAppear {
            viewModel.fetchSeries()
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
