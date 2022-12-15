//
//  WatchOsSeriesApp.swift
//  WatchOsSeries Watch App
//
//  Created by Ricardo Desiderio on 24/11/22.
//

import SwiftUI

@main
struct WatchOsSeries_Watch_AppApp: App {

    // MARK: - INIT
    init() {
        setCacheSizeForURLSession()
    }

    // MARK: - VIEW
    var body: some Scene {
        WindowGroup {
            SeriesPrincipalLandingView()
        }
    }

    // MARK: - OWN METHODS
    private func setCacheSizeForURLSession() {
        URLCache.shared.memoryCapacity = AppGeneralConstants.memoryCacheSize
        URLCache.shared.diskCapacity = AppGeneralConstants.diskCacheSize
    }
}
