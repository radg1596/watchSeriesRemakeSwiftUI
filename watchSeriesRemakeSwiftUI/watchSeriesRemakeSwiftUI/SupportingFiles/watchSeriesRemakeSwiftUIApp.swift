//
//  watchSeriesRemakeSwiftUIApp.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import SwiftUI

@main
struct watchSeriesRemakeSwiftUIApp: App {

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
        URLCache.shared.memoryCapacity = 250 * 1024 * 1024
        URLCache.shared.diskCapacity = 1024 * 1024 * 1024
    }

}
