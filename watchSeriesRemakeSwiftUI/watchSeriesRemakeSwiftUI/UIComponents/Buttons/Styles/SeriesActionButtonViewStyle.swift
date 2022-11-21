//
//  SeriesActionButtonViewStyle.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 18/11/22.
//

import SwiftUI

struct SeriesActionButtonViewStyle: ButtonStyle {

    // MARK: - PROPERTIES
    private let constants = SeriesActionButtonViewStyleConstants()

    // MARK: - PROTOCOL
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(Color.principalBackgroundColor)
            .padding(constants.errorButtonPadding)
            .background(Color.skeletonViewProgressColorOne)
            .clipShape(RoundedRectangle(cornerRadius: constants.errorButtonCornerRadius))
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }

}
