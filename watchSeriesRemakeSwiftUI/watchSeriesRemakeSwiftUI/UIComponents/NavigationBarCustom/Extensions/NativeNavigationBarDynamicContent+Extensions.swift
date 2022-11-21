//
//  NativeNavigationBarDynamicContent+Extensions.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

extension NativeNavigationBarDynamicContent {

    func customNavigationBarTitle(_ title: String) -> some NativeNavigationBarDynamicContent {
        self.data.title = title
        return self
    }

    func customNavigationForegroundColor(_ color: Color) -> some NativeNavigationBarDynamicContent {
        self.data.foregroundColor = color
        return self
    }

    func customNavigationBarLeftBarButton(_ button: NativeNavigationBarButtonType,
                                          onClickCompletion: (() -> Void)? = nil) -> some NativeNavigationBarDynamicContent {
        self.data.leftBarButton = button
        self.data.onLeftClickCompletion = onClickCompletion
        return self
    }

    func customNavigationBarRightBarButton(_ button: NativeNavigationBarButtonType,
                                           onClickCompletion: (() -> Void)? = nil) -> some NativeNavigationBarDynamicContent {
        self.data.rightBarButton = button
        self.data.onRightClickCompletion = onClickCompletion
        return self
    }

}
