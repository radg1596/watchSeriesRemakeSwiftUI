//
//  NativeNavigationBarImageType.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

enum NativeNavigationBarImageType {

    // MARK: - CASES
    case customImage(image: Image)

    // MARK: - PROPERTIES
    var image: Image {
        switch self {
        case .customImage(let image):
            return image
        }
    }

}
