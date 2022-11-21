//
//  Localizables.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 13/11/22.
//

import Foundation

func Localize(_ string: String) ->  String {
    return NSLocalizedString(string,
                             tableName: AppGeneralConstants.localizablesFileName,
                             comment: String())
}
