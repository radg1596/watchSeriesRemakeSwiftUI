//
//  Array+Extensions.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 13/11/22.
//

import Foundation

extension Array {

    func chunked(into size: Int) -> [[Element]] {
        return stride(from: .zero, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }

}
