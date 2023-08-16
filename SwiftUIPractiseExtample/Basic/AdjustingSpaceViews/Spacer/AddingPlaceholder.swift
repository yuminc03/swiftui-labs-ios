//
//  AddingPlaceholder.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct AddingPlaceholder: View {
    var body: some View {
        Text("Spacing with a Placeholder")
        HStack {
            TrainCar(.rear)
            TrainCar(.middle)
                .opacity(0)
                .background(Color.blue.opacity(0.3))
            TrainCar(.front)
        }
        TrainTrack()
    }
}

struct AddingPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AddingPlaceholder()
        }
    }
}
