//
//  AsyncImageCachePhase.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

enum AsyncImageCachePhase {
    case empty
    case success(image: Image)
    case failure(error: Error)
}
