//
//  TrainCarContentView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct TrainCarContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                VStack(spacing: 5) {
                    DefaultSpacing()
                    SpecificPadding()
                    ScaledSpacing()
                    ZeroSpacing()
                }
                VStack(spacing: 5) {
                    DefaultPadding()
                    PaddingSomeEdges()
                    SpecificPadding()
                    PaddingTheContainer()
                }
                VStack(spacing: 5) {
                    AddingSpacer()
                    AddingPlaceholder()
                    StackingPlaceholder()
                }
            }
        }
    }
}

struct TrainCarContentView_Previews: PreviewProvider {
    static var previews: some View {
        TrainCarContentView()
    }
}
