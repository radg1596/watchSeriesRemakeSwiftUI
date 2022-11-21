//
//  NativeNavigationBarData.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

class NativeNavigationBarData: NSObject, NativeNavigationBarDataProtocol {

    // MARK: - PROPERTIES
    var title: String
    var backgroundColor: Color
    var isTranslucent: Bool
    var foregroundColor: Color
    var leftBarButton: NativeNavigationBarButtonType?
    var rightBarButton: NativeNavigationBarButtonType?
    var onLeftClickCompletion: (() -> Void)?
    var onRightClickCompletion: (() -> Void)?

    // MARK: - INIT
    init(title: String,
         backgroundColor: Color,
         isTranslucent: Bool,
         foregroundColor: Color,
         leftBarButton: NativeNavigationBarButtonType? = nil,
         rightBarButton: NativeNavigationBarButtonType? = nil,
         onLeftClickCompletion: (() -> Void)? = nil,
         onRightClickCompletion: (() -> Void)? = nil) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.isTranslucent = isTranslucent
        self.foregroundColor = foregroundColor
        self.leftBarButton = leftBarButton
        self.rightBarButton = rightBarButton
        self.onLeftClickCompletion = onLeftClickCompletion
        self.onRightClickCompletion = onRightClickCompletion
    }

}
