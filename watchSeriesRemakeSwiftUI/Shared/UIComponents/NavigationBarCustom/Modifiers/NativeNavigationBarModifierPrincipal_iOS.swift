//
//  NativeNavigationBarModifierPrincipal.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

#if os(iOS)
struct NativeNavigationBarModifierPrincipal_iOS: ViewModifier {

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
        configureNavigationBarColors(backgroundColor: backgroundColor)
        return getViewFor(content: content)
    }

    // MARK
    @ViewBuilder
    /// Has a very strange scenerio, not using the #available the color opaque is not working...
    private func getViewFor(content: Content) -> some View {
        if #available(iOS 16, *) {
            content
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    principalToolbarItemView_iOS
                    leftToolbarItemView_iOS
                    rightToolbarItemView_iOS
                }
        } else {
            content
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    principalToolbarItemView_iOS
                    leftToolbarItemView_iOS
                    rightToolbarItemView_iOS
                }
        }
    }

    // MARK: - IOS
    private var principalToolbarItemView_iOS: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.title3)
                .bold()
                .foregroundColor(foregroundColor)
        }
    }

    private var leftToolbarItemView_iOS: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                onLeftClick?()
            } label: {
                if let leftBarButton = leftBarButton {
                    leftBarButton.view
                        .foregroundColor(foregroundColor)
                }
            }
        }
    }

    private var rightToolbarItemView_iOS: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                onRightClick?()
            } label: {
                if let rightBarButton = rightBarButton {
                    rightBarButton.view
                        .foregroundColor(foregroundColor)
                }
            }
        }
    }

    // MARK: - OWN METHODS
    private func configureNavigationBarColors(backgroundColor: Color) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        let colorForBackground = isTranslucent ? UIColor(backgroundColor).withAlphaComponent(0.75) : UIColor(backgroundColor)
        coloredAppearance.backgroundColor = colorForBackground
        coloredAppearance.backgroundEffect = .none
        coloredAppearance.shadowColor = nil
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().isTranslucent = isTranslucent
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = coloredAppearance
        }
    }

}

#endif
