//
//  SpecificPadding.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct SpecificPadding: View {
    var body: some View {
        Text("Padding Some Edges")
        HStack {
            TrainCar(.rear)
            TrainCar(.middle)
                .padding(5)
                .background(Color.blue.opacity(0.3))
            TrainCar(.front)
        }
        TrainTrack()
    }
}

struct SpecificPadding_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SpecificPadding()
        }
    }
}
