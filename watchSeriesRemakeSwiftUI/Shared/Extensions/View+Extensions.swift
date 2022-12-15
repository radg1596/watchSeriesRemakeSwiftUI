//
//  View+Extensions.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 16/11/22.
//

import SwiftUI

extension View {

    func showNoInternetConnection(isPresented: Binding<Bool>,
                                  cancelCompletion: (() -> Void)? = nil,
                                  retryCompletion: (() -> Void)? = nil ) -> some View {
        let titleForAlert = SeriesGeneralLocalizableStrings.generalErrorNoInternetAvailableTitle.localize
        let messageAlert = SeriesGeneralLocalizableStrings.generalErrorNoInternetAvailableMessage.localize
        let cancelButtonText = SeriesGeneralLocalizableStrings.generalButtonTextCancel.localize
        let retryButtonText = SeriesGeneralLocalizableStrings.generalButtonTextRetry.localize
        return alert(isPresented: isPresented) {
            Alert(title: Text(titleForAlert),
                  message: Text(messageAlert),
                  primaryButton: Alert.Button.cancel(Text(cancelButtonText)) {
                DispatchQueue.main.async { cancelCompletion?() }
            }, secondaryButton: Alert.Button.default(Text(retryButtonText)) {
                DispatchQueue.main.async { retryCompletion?() }
            })
        }
    }

}
