//
//  City.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/04.
//

import Foundation

struct City: Equatable, Identifiable {
  let id = UUID()
  let name: String
  
  static let dummy: [City] = [
    .init(name: "갈라파고스 제도, 에콰도르"),
    .init(name: "그린 베이, 미국"),
    .init(name: "나폴리, 이탈리아"),
    .init(name: "네이터즈, 스위스"),
    .init(name: "누크, 그린란드"),
    .init(name: "니피곤, 캐나다"),
    .init(name: "더블린, 아일랜드"),
    .init(name: "도하, 카타르"),
    .init(name: "리우데자네이루, 브라질"),
    .init(name: "방콕, 태국")
  ]
  
  static let alarmSoundsDummy: [City] = [
    .init(name: "전파 탐지기(기본 설정"),
    .init(name: "공상음"),
    .init(name: "공지음"),
    .init(name: "녹차"),
    .init(name: "놀이 시간"),
    .init(name: "느린 상승"),
    .init(name: "도입음"),
    .init(name: "물결"),
    .init(name: "반짝반짝"),
    .init(name: "반향"),
    .init(name: "발산"),
    .init(name: "밤부엉이"),
    .init(name: "별자리"),
    .init(name: "상승음"),
    .init(name: "순환음"),
    .init(name: "신호"),
    .init(name: "신호음"),
    .init(name: "실크"),
    .init(name: "우주"),
    .init(name: "일루미네이트"),
    .init(name: "절정"),
    .init(name: "정점"),
    .init(name: "차임벨"),
    .init(name: "크리스탈"),
    .init(name: "파장"),
    .init(name: "프레스토"),
    .init(name: "해변가"),
    .init(name: "희망"),
    .init(name: "클래식")
  ]
}
