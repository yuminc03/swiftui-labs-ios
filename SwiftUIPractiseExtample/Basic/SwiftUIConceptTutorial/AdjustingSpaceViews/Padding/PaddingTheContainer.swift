//
//  PaddingTheContainer.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct PaddingTheContainer: View {
    var body: some View {
        Text("Padding the Container")
        HStack {
            TrainCar(.rear)
            TrainCar(.middle)
            TrainCar(.front)
        }
        .padding()
        .background(Color.blue.opacity(0.3))
        TrainTrack()
    }
}

struct PaddingTheContainer_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PaddingTheContainer()
        }
    }
}
