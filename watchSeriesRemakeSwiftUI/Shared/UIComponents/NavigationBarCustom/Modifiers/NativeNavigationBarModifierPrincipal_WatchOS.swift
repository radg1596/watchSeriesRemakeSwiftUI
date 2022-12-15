//
//  NativeNavigationBarModifierPrincipal_WatchOS.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 14/12/22.
//

import SwiftUI

#if os(watchOS)
struct NativeNavigationBarModifierPrincipal_WatchOS: ViewModifier {

    // MARK: - PROPERTIES
    private let title: String
    private let isTranslucent: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let leftBarButton: NativeNavigationBarButtonType?
    private let rightBarButton: NativeNavigationBarButtonType?
    private var onLeftClick: (() -> Void)?
    private var onRightClick: (() -> Void)?

    // MARK: - INIT
    init(title: String,
         isTranslucent: Bool,
         backgroundColor: Color,
         foregroundColor: Color,
         leftBarButton: NativeNavigationBarButtonType? = nil,
         rightBarButton: NativeNavigationBarButtonType? = nil,
         onLeftClick: (() -> Void)? = nil,
         onRightClick: (() -> Void)? = nil) {
        self.title = title
        self.isTranslucent = isTranslucent
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.leftBarButton = leftBarButton
        self.rightBarButton = rightBarButton
        self.onLeftClick = onLeftClick
        self.onRightClick = onRightClick
    }

    // MARK: - BODY
    func body(content: Content) -> some View {
        if #available(watchOS 9.0, *) {
            navigationViewTitleIOS9AndLater(content: content)
        } else {
            navigationViewTitleIOS9Before(content: content)
        }
    }

    // MARK: - WATCH
    @available(watchOS 9.0, *)
    private func navigationViewTitleIOS9AndLater(content: Content) -> some View {
        content
        .navigationTitle {
            HStack {
                Text(title)
                    .bold()
                    .font(.title3)
                    .foregroundColor(foregroundColor)
                Spacer()
            }
        }
        .toolbarBackground(backgroundColor.opacity(isTranslucent ? 0.75 : 1.0),
                           for: .navigationBar)
    }

    private func navigationViewTitleIOS9Before(content: Content) -> some View {
        content
            .navigationTitle {
                HStack {
                    Text(title)
                        .bold()
                        .font(.title3)
                        .foregroundColor(foregroundColor)
                    Spacer()
                }
            }
    }

}
#endif
