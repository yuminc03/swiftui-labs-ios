//
//  KeyPadNumberDTO.swift
//  KeyPad
//
//  Created by Yumin Chu on 2023/08/19.
//

import Foundation

struct KeyPadNumberDTO: Equatable, Identifiable {
    let id = UUID().uuidString
    let numberText: String
    let smallText: String
}
