//
//  NativeNavigationBarView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

struct NativeNavigationBarView<Content: View>: NativeNavigationBarDynamicContent {

    // MARK: - PROPERTIES
    var data: NativeNavigationBarDataProtocol

    // MARK: - CONTENT
    private var content: () -> Content

    // MARK: - INIT
    init(title: String = String(),
         backgroundColor: Color = .secondaryBackgroundColor,
         isTranslucent: Bool = false,
         foregroundColor: Color = .textPrimaryColor,
         content: @escaping () -> Content) {
        self.data = NativeNavigationBarData(title: title,
                                            backgroundColor: backgroundColor,
                                            isTranslucent: isTranslucent,
                                            foregroundColor: foregroundColor,
                                            leftBarButton: nil,
                                            rightBarButton: nil,
                                            onLeftClickCompletion: nil,
                                            onRightClickCompletion: nil)
        self.content = content
    }

    // MARK: - BODY
    var body: some View {
    #if os(watchOS)
        return content()
            .modifier(NativeNavigationBarModifierPrincipal_WatchOS(title: data.title,
                                                                   isTranslucent: data.isTranslucent,
                                                                   backgroundColor: data.backgroundColor,
                                                                   foregroundColor: data.foregroundColor,
                                                                   leftBarButton: data.leftBarButton,
                                                                   rightBarButton: data.rightBarButton,
                                                                   onLeftClick: data.onLeftClickCompletion,
                                                                   onRightClick: data.onRightClickCompletion))
    #endif
    #if os(iOS)
        return content()
            .modifier(NativeNavigationBarModifierPrincipal_iOS(title: data.title,
                                                               isTranslucent: data.isTranslucent,
                                                               backgroundColor: data.backgroundColor,
                                                               foregroundColor: data.foregroundColor,
                                                               leftBarButton: data.leftBarButton,
                                                               rightBarButton: data.rightBarButton,
                                                               onLeftClick: data.onLeftClickCompletion,
                                                               onRightClick: data.onRightClickCompletion))
    #endif
    }

}

