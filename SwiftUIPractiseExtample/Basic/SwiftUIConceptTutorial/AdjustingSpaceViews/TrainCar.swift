//
//  TrainCar.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

enum TrainSymbol: String {
    case front = "train.side.front.car"
    case middle = "train.side.middle.car"
    case rear = "train.side.rear.car"
}

struct TrainCar: View {
    let position: TrainSymbol
    let isFrameShow: Bool
    
    init(_ position: TrainSymbol, isFrameShow: Bool = true) {
        self.position = position
        self.isFrameShow = isFrameShow
    }
    
    var body: some View {
        Image(systemName: position.rawValue)
            .border(isFrameShow ? .gray : .clear, width: 0.5)
    }
}

struct TrainTrack: View {
    var body: some View {
        Divider()
            .frame(maxWidth: 200)
    }
}

struct TrainCar_Previews: PreviewProvider {
    static var previews: some View {
        TrainCar(.front)
    }
}
