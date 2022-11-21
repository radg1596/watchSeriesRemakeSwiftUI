//
//  SeriesTripleActionBarView.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 18/11/22.
//

import SwiftUI

struct SeriesTripleActionBarView: View {

    // MARK: - PROPERTIES
    private let leftButtonTitle: String
    private let leftButtonSysImageName: String
    private let onClickLeftButton: (() -> Void)?
    private let middleButtonTitle: String
    private let middleButtonSysImageName: String
    private let onClickMiddleButton: (() -> Void)?
    private let rightButtonTitle: String
    private let rightButtonSysImageName: String
    private let onClickRightButton: (() -> Void)?

    // MARK: - INIT
    init(leftButtonTitle: String = String(),
         leftButtonSysImageName: String = String(),
         onClickLeftButton: (() -> Void)? = nil,
         middleButtonTitle: String = String(),
         middleButtonSysImageName: String = String(),
         onClickMiddleButton: (() -> Void)? = nil,
         rightButtonTitle: String = String(),
         rightButtonSysImageName: String = String(),
         onClickRightButton: (() -> Void)? = nil) {
        self.leftButtonTitle = leftButtonTitle
        self.leftButtonSysImageName = leftButtonSysImageName
        self.onClickLeftButton = onClickLeftButton
        self.middleButtonTitle = middleButtonTitle
        self.middleButtonSysImageName = middleButtonSysImageName
        self.onClickMiddleButton = onClickMiddleButton
        self.rightButtonTitle = rightButtonTitle
        self.rightButtonSysImageName = rightButtonSysImageName
        self.onClickRightButton = onClickRightButton
    }

    // MARK: - BODY
    var body: some View {
        HStack {
            leftButtonView
                .buttonStyle(.actionStyle)
            middleButtonView
                .buttonStyle(.actionStyle)
            rightButtonView
                .buttonStyle(.actionStyle)
        }
    }

    // MARK: - BUTTONS
    var leftButtonView: some View {
        Button {
            onClickLeftButton?()
        } label: {
            Label(leftButtonTitle,
                  systemImage: leftButtonSysImageName)
        }
    }

    var middleButtonView: some View {
        Button {
            onClickMiddleButton?()
        } label: {
            Label(middleButtonTitle,
                  systemImage: middleButtonSysImageName)
        }
    }

    var rightButtonView: some View {
        Button {
            onClickRightButton?()
        } label: {
            Label(rightButtonTitle,
                  systemImage: rightButtonSysImageName)
        }
    }

}

struct SeriesTripleActionBarView_Previews: PreviewProvider {

    static var previews: some View {
        SeriesTripleActionBarView()
    }

}
