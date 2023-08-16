//
//  DefaultSpacing.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct DefaultSpacing: View {
    var body: some View {
        Text("Default Spacing")
        HStack {
            TrainCar(.rear)
            TrainCar(.middle)
            TrainCar(.front)
        }
        TrainTrack()
    }
}

struct DefaultSpacing_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DefaultSpacing()
        }
    }
}
