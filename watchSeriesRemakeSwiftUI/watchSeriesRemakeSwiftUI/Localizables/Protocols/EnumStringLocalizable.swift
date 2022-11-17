//
//  EnumStringLocalizable.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 13/11/22.
//

import Foundation

protocol EnumStringLocalizable {

    var localize: String { get }

}

extension EnumStringLocalizable where Self: RawRepresentable<String> {

    var localize: String {
        return Localize(self.rawValue)
    }

}
