//
//  NativeNavigationBarModifierPrincipal.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

struct NativeNavigationBarModifierPrincipal: ViewModifier {

    // MARK: - PROPERTIES
    private let title: String
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let leftBarButton: NativeNavigationBarButtonType?
    private let rightBarButton: NativeNavigationBarButtonType?
    private var onLeftClick: (() -> Void)?
    private var onRightClick: (() -> Void)?

    // MARK: - INIT
    init(title: String,
         backgroundColor: Color,
         foregroundColor: Color,
         leftBarButton: NativeNavigationBarButtonType? = nil,
         rightBarButton: NativeNavigationBarButtonType? = nil,
         onLeftClick: (() -> Void)? = nil,
         onRightClick: (() -> Void)? = nil) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.leftBarButton = leftBarButton
        self.rightBarButton = rightBarButton
        self.onLeftClick = onLeftClick
        self.onRightClick = onRightClick
    }

    // MARK: - BODY
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                principalToolbarItemView
                leftToolbarItemView
                rightToolbarItemView
            }
    }

    var principalToolbarItemView: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.title3)
                .bold()
                .foregroundColor(foregroundColor)
        }
    }

    var leftToolbarItemView: some ToolbarContent {
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

    var rightToolbarItemView: some ToolbarContent {
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

}
