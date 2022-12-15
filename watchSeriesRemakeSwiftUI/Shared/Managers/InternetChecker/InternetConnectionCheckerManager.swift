//
//  InternetConnectionCheckerManager.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 16/11/22.
//

import Foundation
import Combine
import Alamofire
import Network

final class InternetConnectionCheckerManager: InternetConnectionCheckeable {

    // MARK: - PROPERTIES
   #if os(iOS)
    private var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    #endif

    // MARK: - METHODS
    func networkCheckerPublisher() -> AnyPublisher<Bool, Never> {
        #if os(watchOS)
        Future { promise in
            let netMonitor = NWPathMonitor(requiredInterfaceType: .wifi)
            let queue = DispatchQueue.global(qos: .background)
            netMonitor.start(queue: queue)
            netMonitor.pathUpdateHandler = { (path: NWPath) in
                promise(.success(path.status == .satisfied))
            }
        }
        .eraseToAnyPublisher()
        #else
        Future { [weak self] promise in
            guard let self = self else { return }
            promise(.success(self.isReachable))
        }
        .eraseToAnyPublisher()
        #endif
    }

}
