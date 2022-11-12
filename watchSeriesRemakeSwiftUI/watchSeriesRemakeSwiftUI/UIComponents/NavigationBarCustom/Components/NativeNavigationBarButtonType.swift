//
//  NativeNavigationBarButtonType.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

enum NativeNavigationBarButtonType {

    // MARK: - CASES
    case text(text: String)
    case image(type: NativeNavigationBarImageType)

    // MARK: - METHODS
    @ViewBuilder var view: some View {
        switch self {
        case .text(let text):
            Text(text)
        case .image(let type):
            type.image
                .renderingMode(.template)
        }
    }

}
