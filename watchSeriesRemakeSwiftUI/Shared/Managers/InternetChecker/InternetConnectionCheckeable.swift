//
//  InternetConnectionCheckeable.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 16/11/22.
//

import Foundation
import Combine

protocol InternetConnectionCheckeable {
    func networkCheckerPublisher() -> AnyPublisher<Bool, Never>
}
