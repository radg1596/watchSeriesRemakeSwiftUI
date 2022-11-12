//
//  NativeNavigationBarDynamicContent.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 10/11/22.
//

import SwiftUI

protocol NativeNavigationBarDynamicContent: View {
    var data: NativeNavigationBarDataProtocol { get set }
}
