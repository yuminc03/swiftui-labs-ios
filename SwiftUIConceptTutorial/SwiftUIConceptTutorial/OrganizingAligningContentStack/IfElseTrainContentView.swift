//
//  IfElseTrainContentView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/17.
//

import SwiftUI

struct IfElseTrainContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            IfElseTrain(isLongerTrain: true)
            IfElseTrain(isLongerTrain: false)
            OpacityTrain(isLongerTrain: true)
            OpacityTrain(isLongerTrain: false)
        }
    }
}

struct IfElseTrainContentView_Previews: PreviewProvider {
    static var previews: some View {
        IfElseTrainContentView()
    }
}
