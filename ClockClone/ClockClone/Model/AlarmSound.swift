//
//  AlarmSound.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/08.
//

import Foundation

import ComposableArchitecture

struct AlarmSound: Equatable, Identifiable {
  let id = UUID()
  let name: String
  var isSelected = false
  
  static let alarmSoundsDummy: IdentifiedArrayOf<AlarmSound> = [
    .init(name: "전파 탐지기(기본 설정)"),
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
  
  static let classicDummy: IdentifiedArrayOf<AlarmSound> = [
    .init(name: "개 짖는 소리"),
    .init(name: "경보기"),
    .init(name: "공 튀기는 소리"),
    .init(name: "공상과학"),
    .init(name: "구식 자동차 경적"),
    .init(name: "귀뚜라미 소리"),
    .init(name: "기계음"),
    .init(name: "기타"),
    .init(name: "로보트 소리"),
    .init(name: "마림바"),
    .init(name: "블루스"),
    .init(name: "상승음"),
    .init(name: "수중 음파 탐지기"),
    .init(name: "시계바늘 움직임"),
    .init(name: "실로폰"),
    .init(name: "오리소리"),
    .init(name: "오토바이"),
    .init(name: "전화 벨소리"),
    .init(name: "종탑 소리"),
    .init(name: "초인종 소리"),
    .init(name: "타악기"),
    .init(name: "트릴"),
    .init(name: "피아노 연주"),
    .init(name: "핀볼 소리"),
    .init(name: "하프")
  ]
}
