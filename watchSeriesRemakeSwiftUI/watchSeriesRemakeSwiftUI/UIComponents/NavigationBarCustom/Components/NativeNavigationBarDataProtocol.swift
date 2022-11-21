//
//  NativeNavigationBarDataProtocol.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

protocol NativeNavigationBarDataProtocol: AnyObject {
    var title: String { get set }
    var isTranslucent: Bool { get set }
    var backgroundColor: Color { get set }
    var foregroundColor: Color { get set }
    var leftBarButton: NativeNavigationBarButtonType? { get set }
    var rightBarButton: NativeNavigationBarButtonType? { get set }
    var onLeftClickCompletion: (() -> Void)? { get set }
    var onRightClickCompletion: (() -> Void)? { get set }
}
