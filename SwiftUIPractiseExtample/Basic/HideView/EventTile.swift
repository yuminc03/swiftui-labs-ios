//
//  EventTile.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/16.
//

import SwiftUI

struct EventTile: View {
    let event: Event
    let stripeHieght = 15.0
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: event.symbol)
                .font(.title)
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.title)
                Text(
                    event.date,
                    format: Date.FormatStyle()
                        .day(.defaultDigits)
                        .month(.wide)
                )
                Text(event.location)
            }
        }
        .padding()
        .padding(.top, stripeHieght)
        .background {
            ZStack(alignment: .top) {
                Rectangle()
                    .opacity(0.3)
                Rectangle()
                    .frame(maxHeight: stripeHieght)
            }
            .foregroundColor(.teal)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: stripeHieght, style: .continuous)
        )
    }
}

struct EventTile_Previews: PreviewProvider {
    static let event = Event(
        title: "Buy Daisies",
        date: .now,
        location: "Flower Shop",
        symbol: "gift"
    )
    static var previews: some View {
        EventTile(event: event)
    }
}
