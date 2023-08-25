//
//  HIstory.swift
//  Scrumdinger
//
//  Created by Yumin Chu on 2023/08/25.
//

import Foundation

struct History: Identifiable, Codable {
  let id: UUID
  let date: Date
  var attendees: [DailyScrum.Attendee]
  
  init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {
    self.id = id
    self.date = date
    self.attendees = attendees
  }
}
