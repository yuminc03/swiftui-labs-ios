//
//  ListView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/05.
//

import SwiftUI

struct ListView: View {
  let tasks = ["Task1", "Task2", "Task3", "Task4", "Task5"]
  var body: some View {
    List(tasks, id: \.self) { task in
      Text(task)
    }
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView()
  }
}
