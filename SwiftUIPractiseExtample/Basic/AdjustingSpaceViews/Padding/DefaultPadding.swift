//
//  DefaultPadding.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct DefaultPadding: View {
    var body: some View {
        Text("Default Padding")
        HStack {
            TrainCar(.rear)
            TrainCar(.middle)
                .padding()
                .background(Color.blue.opacity(0.3))
            TrainCar(.front)
        }
        TrainTrack()
    }
}

struct DefaultPadding_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DefaultPadding()
        }
    }
}
