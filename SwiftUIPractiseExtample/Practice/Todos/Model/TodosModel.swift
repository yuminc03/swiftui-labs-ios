//
//  TodosModel.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/06/18.
//

import Foundation

struct TodoModel: Decodable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
