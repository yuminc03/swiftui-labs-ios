//
//  IfElseTrain.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct IfElseTrain: View {
    var isLongerTrain: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "train.side.rear.car")
                if isLongerTrain {
                    Image(systemName: "train.side.middle.car")
                }
                Image(systemName: "train.side.front.car")
            }
            Divider()
        }
    }
}

struct OpacityTrain: View {
    var isLongerTrain: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "train.side.rear.car")
                Image(systemName: "train.side.middle.car").opacity(isLongerTrain ? 1 : 0)
                Image(systemName: "train.side.front.car")
            }
            Divider()
        }
    }
}

struct IfElseTrain_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            IfElseTrain(isLongerTrain: true)
            IfElseTrain(isLongerTrain: false)
            OpacityTrain(isLongerTrain: true)
            OpacityTrain(isLongerTrain: false)
        }
    }
}
