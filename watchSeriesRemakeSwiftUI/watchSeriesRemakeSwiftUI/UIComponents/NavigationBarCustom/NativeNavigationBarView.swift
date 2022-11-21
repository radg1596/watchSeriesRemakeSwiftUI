//
//  NativeNavigationBarView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

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
        configureNavigationBarColors(backgroundColor: backgroundColor)
    }


    // MARK: - BODY
    var body: some View {
        return content()
            .modifier(NativeNavigationBarModifierPrincipal(title: data.title,
                                                           backgroundColor: data.backgroundColor,
                                                           foregroundColor: data.foregroundColor,
                                                           leftBarButton: data.leftBarButton,
                                                           rightBarButton: data.rightBarButton,
                                                           onLeftClick: data.onLeftClickCompletion,
                                                           onRightClick: data.onRightClickCompletion))
    }

    // MARK: - OWN METHODS
    private func configureNavigationBarColors(backgroundColor: Color) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.shadowColor = nil
        let colorForBackground = data.isTranslucent ? UIColor(backgroundColor).withAlphaComponent(0.85) : UIColor(backgroundColor)
        coloredAppearance.backgroundColor = colorForBackground
        coloredAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = coloredAppearance
        }
    }

}

