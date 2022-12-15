//
//  SeriesPreviewItemViewConstants.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 11/11/22.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - CONSTANTS CLASS
struct SeriesPreviewItemViewConstants {

    /// Default height for the item
    #if os(watchOS)
    let frameHeightFactor: CGFloat = 1.0
    let frameWidthFactor: CGFloat = 0.65
    #else
    var frameHeightFactor: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 0.4
        } else {
            return 0.25
        }
    }
    var frameWidthFactor: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 0.3
        } else {
            return 0.15
        }
    }
    #endif
    let cornerRadiusForView: CGFloat = 5.0

}
