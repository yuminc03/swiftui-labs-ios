//
//  ZeroSpacing.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct ZeroSpacing: View {
    var body: some View {
        Text("Zero Spacing")
        HStack(spacing: 0) {
            TrainCar(.rear)
            TrainCar(.middle)
            TrainCar(.front)
        }
        TrainTrack()
    }
}

struct ZeroSpacing_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZeroSpacing()
        }
    }
}
