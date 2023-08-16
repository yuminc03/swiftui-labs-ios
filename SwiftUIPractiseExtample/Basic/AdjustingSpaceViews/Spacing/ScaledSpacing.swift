//
//  ScaledSpacing.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct ScaledSpacing: View {
    @ScaledMetric var trainCarSpacing = 5
    var body: some View {
        Text("Scaled Spacing")
        HStack(spacing: trainCarSpacing) {
            TrainCar(.rear)
            TrainCar(.middle)
            TrainCar(.front)
        }
        TrainTrack()
    }
}

struct ScaledSpacing_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScaledSpacing()
        }
    }
}
