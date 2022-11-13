//
//  SkeletonViewBase.swift
//  watchSeriesRemakeSwiftUI
//
//  Created by Ricardo Desiderio on 11/11/22.
//

import SwiftUI

struct SkeletonViewBase: View {

    // MARK: - PROPERTIES OF STATE
    @State private var startPointOfGradient: UnitPoint
    @State private var endPointOfGradient: UnitPoint
    @State private var colorsOfGradient: [Color]

    // MARK: - PROPERTIES
    private let constants = SkeletonViewBaseConstants()

    // MARK: - GRADIENT
    private var gradienFillView: LinearGradient {
        LinearGradient(colors: colorsOfGradient,
                                      startPoint: startPointOfGradient,
                                      endPoint: endPointOfGradient)
    }

    // MARK: - INIT
    init(startPointOfGradient: UnitPoint = UnitPoint.bottomLeading,
         endPointOfGradient: UnitPoint = UnitPoint.topTrailing,
         colorsOfGradient: [Color] = [ .skeletonViewProgressColorOne,
                                       .skeletonViewProgressColorTwo]) {
        self.startPointOfGradient = startPointOfGradient
        self.endPointOfGradient = endPointOfGradient
        self.colorsOfGradient = colorsOfGradient
    }

    // MARK: - BODY
    var body: some View {
        GeometryReader { geometryProxy in
            VStack {
                let availableWidth = geometryProxy.size.width
                let cornerRadius = availableWidth * constants.cornerRadiusFactor
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(gradienFillView)
            }
        }
        .onAppear {
            let animationForSkeleton = Animation
                .easeInOut(duration: constants.animationTime)
                .repeatForever()
            withAnimation(animationForSkeleton) {
                startPointOfGradient = UnitPoint(x: constants.endPointAnimationX,
                                                 y: .zero)
            }
        }
    }
}

struct SkeletonViewBase_Previews: PreviewProvider {

    static var previews: some View {
        let constants = SkeletonViewBaseConstants()
        SkeletonViewBase()
            .frame(width: constants.previewFrameSize,
                   height: constants.previewFrameSize)
    }

}
