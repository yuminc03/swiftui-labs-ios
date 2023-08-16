//
//  StackingPlaceholder.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct StackingPlaceholder: View {
    var body: some View {
        Text("Stacking with a Placeholder")
        HStack {
            TrainCar(.rear)
            ZStack {
                TrainCar(.middle)
                    .font(.largeTitle)
                    .opacity(0)
                    .background(Color.blue.opacity(0.3))
                TrainCar(.middle)
            }
            TrainCar(.front)
        }
        TrainTrack()
    }
}

struct StackingPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StackingPlaceholder()
        }
    }
}
