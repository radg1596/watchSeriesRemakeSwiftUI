//
//  Encodable+Extensions.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 08/11/22.
//

import Foundation

extension Encodable {

    var dictionary: [String: Any]? {
        guard let dataOfJson = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: dataOfJson, options: .fragmentsAllowed) as? [String: Any]
     }

}
