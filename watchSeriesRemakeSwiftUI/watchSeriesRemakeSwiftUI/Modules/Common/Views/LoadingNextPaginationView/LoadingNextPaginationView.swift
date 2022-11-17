//
//  LoadingNextPaginationView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 15/11/22.
//

import SwiftUI

struct LoadingNextPaginationView: View {

    // MARK: - LOADING TEXT
    private let loadingText: String

    // MARK: - INIT
    init(loadingText: String = String()) {
        self.loadingText = loadingText
    }

    // MARK: - BODY
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .textPrimaryColor))
                .padding()
            Text(loadingText)
                .foregroundColor(.textPrimaryColor)
                .multilineTextAlignment(.center)
                .padding()
        }
        .background(Color.principalBackgroundColor)
    }

}

struct LoadingNextPaginationView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingNextPaginationView()
    }
}
