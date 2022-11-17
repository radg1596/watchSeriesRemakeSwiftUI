//
//  InternetConnectionCheckerManager.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 16/11/22.
//

import Foundation
import Combine
import Alamofire

final class InternetConnectionCheckerManager: InternetConnectionCheckeable {

    // MARK: - PROPERTIES
    private var isReachable: Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }

    // MARK: - METHODS
    func networkCheckerPublisher() -> AnyPublisher<Bool, Never> {
        Future { [weak self] promise in
            guard let self = self else { return }
            promise(.success(self.isReachable))
        }
        .eraseToAnyPublisher()
    }

}
