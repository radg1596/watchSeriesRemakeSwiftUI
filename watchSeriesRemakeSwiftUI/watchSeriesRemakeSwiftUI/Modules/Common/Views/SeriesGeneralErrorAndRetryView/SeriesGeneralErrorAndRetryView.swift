//
//  SeriesGeneralErrorAndRetryView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 16/11/22.
//

import SwiftUI

struct SeriesGeneralErrorAndRetryView: View {

    // MARK: - VIEW PROPERTIES
    private let errorMessageText: String
    private let errorRetryButtonText: String
    private var errorRetryButtonAction: (() -> Void)?

    // MARK: - OTHER PROPERTIES
    private let constants = SeriesGeneralErrorAndRetryViewConstants()

    // MARK: - INIT
    init(errorMessageText: String = String(),
         errorRetryButtonText: String = String(),
         errorRetryButtonAction: (() -> Void)? = nil) {
        self.errorMessageText = errorMessageText
        self.errorRetryButtonText = errorRetryButtonText
        self.errorRetryButtonAction = errorRetryButtonAction
    }

    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            errorMessage
                .padding()
            errorRetryButton
            Spacer()
            Spacer()
            Spacer()
        }
        .background(Color.principalBackgroundColor)
    }

    // MARK: - ERROR MESSAGE
    var errorMessage: some View {
        HStack {
            Spacer()
            Text(errorMessageText)
                .foregroundColor(Color.textPrimaryColor)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }

    var errorRetryButton: some View {
        HStack {
            Button(errorRetryButtonText) {
                DispatchQueue.main.async {
                    self.errorRetryButtonAction?()
                }
            }
            .foregroundColor(Color.principalBackgroundColor)
            .padding(constants.errorButtonPadding)
            .background(Color.skeletonViewProgressColorOne)
            .clipShape(RoundedRectangle(cornerRadius: constants.errorButtonCornerRadius))
        }
    }

}

// MARK: - PREVIEW
struct SeriesGeneralErrorAndRetryView_Preview: PreviewProvider {

    static var previews: some View {
        SeriesGeneralErrorAndRetryView()
    }

}
