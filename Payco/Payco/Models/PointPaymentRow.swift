//
//  PointPaymentRow.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/27.
//

import Foundation

struct PointPaymentRow: Identifiable, Equatable {
  let id = UUID()
  let imageName: String
  let toptitle: String
  let bottomTitle: String
  
  static let dummy1: [PointPaymentRow] = [
    .init(imageName: "swift", toptitle: "IBK 계좌 페이코 충전 시", bottomTitle: "5,000P 적립"),
    .init(imageName: "swift", toptitle: "클룩 결제 시", bottomTitle: "5,000원 할인"),
    .init(imageName: "swift", toptitle: "무신사 결제 시", bottomTitle: "2% 할인"),
    .init(imageName: "swift", toptitle: "29CM 결제 시", bottomTitle: "2% 할인"),
    .init(imageName: "swift", toptitle: "에듀윌 결제 시", bottomTitle: "5,000원 할인"),
    .init(imageName: "swift", toptitle: "에버온 전기차 충전 시", bottomTitle: "최대 10,000원 할인"),
    .init(imageName: "swift", toptitle: "교보문고 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "이디야 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "AK플라자 결제 시", bottomTitle: "최대 16% 상품권 지급"),
    .init(imageName: "swift", toptitle: "GS더프레시 결제 시", bottomTitle: "3,000원 할인"),
    .init(imageName: "swift", toptitle: "메가MGC커피 결제 시", bottomTitle: "최대 15% 할인"),
    .init(imageName: "swift", toptitle: "독립생활 결제 시", bottomTitle: "최대 10,000원 할인"),
    .init(imageName: "swift", toptitle: "올리브영 결제할 때마다", bottomTitle: "최대 1,000P 적립"),
    .init(imageName: "swift", toptitle: "11번가 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "티몬 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "티켓링크 공연 결제 시", bottomTitle: "최대 1,000P 적립"),
    .init(imageName: "swift", toptitle: "위메프 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "GS25 결제 시 건당", bottomTitle: "15% 적립"),
    .init(imageName: "swift", toptitle: "이디야 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "CU 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "롯데리아 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "미니스톱 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "세븐일레븐 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "빽다방 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "한게임 결제 시 건당", bottomTitle: "4% 적립"),
    .init(imageName: "swift", toptitle: "애터미 결제 시 건당", bottomTitle: "2% 적립"),
    .init(imageName: "swift", toptitle: "바로팜 결제 시 건당", bottomTitle: "2% 적립"),
    .init(imageName: "swift", toptitle: "마켓컬리 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "네이처컬렉션 결제 시", bottomTitle: "5,000원 즉시할인"),
    .init(imageName: "swift", toptitle: "버거킹 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "매머드커피 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "다이소 결제 시 건당", bottomTitle: "10% 적립")
  ]
  
  static let dummy2: [PointPaymentRow] = [
    .init(imageName: "swift", toptitle: "IBK 계좌 페이코 충전 시", bottomTitle: "5,000P 적립"),
    .init(imageName: "swift", toptitle: "클룩 결제 시", bottomTitle: "5,000원 할인"),
    .init(imageName: "swift", toptitle: "무신사 결제 시", bottomTitle: "2% 할인"),
    .init(imageName: "swift", toptitle: "29CM 결제 시", bottomTitle: "2% 할인"),
    .init(imageName: "swift", toptitle: "에듀윌 결제 시", bottomTitle: "5,000원 할인"),
    .init(imageName: "swift", toptitle: "에버온 전기차 충전 시", bottomTitle: "최대 10,000원 할인"),
    .init(imageName: "swift", toptitle: "교보문고 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "이디야 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "AK플라자 결제 시", bottomTitle: "최대 16% 상품권 지급"),
    .init(imageName: "swift", toptitle: "GS더프레시 결제 시", bottomTitle: "3,000원 할인"),
    .init(imageName: "swift", toptitle: "메가MGC커피 결제 시", bottomTitle: "최대 15% 할인"),
    .init(imageName: "swift", toptitle: "독립생활 결제 시", bottomTitle: "최대 10,000원 할인"),
    .init(imageName: "swift", toptitle: "올리브영 결제할 때마다", bottomTitle: "최대 1,000P 적립"),
    .init(imageName: "swift", toptitle: "11번가 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "티몬 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "티켓링크 공연 결제 시", bottomTitle: "최대 1,000P 적립")
  ]
  
  static let dummy3: [PointPaymentRow] = [
    .init(imageName: "swift", toptitle: "IBK 계좌 페이코 충전 시", bottomTitle: "5,000P 적립"),
    .init(imageName: "swift", toptitle: "클룩 결제 시", bottomTitle: "5,000원 할인"),
    .init(imageName: "swift", toptitle: "무신사 결제 시", bottomTitle: "2% 할인"),
    .init(imageName: "swift", toptitle: "29CM 결제 시", bottomTitle: "2% 할인"),
    .init(imageName: "swift", toptitle: "에듀윌 결제 시", bottomTitle: "5,000원 할인"),
    .init(imageName: "swift", toptitle: "에버온 전기차 충전 시", bottomTitle: "최대 10,000원 할인"),
    .init(imageName: "swift", toptitle: "교보문고 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "이디야 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "AK플라자 결제 시", bottomTitle: "최대 16% 상품권 지급"),
    .init(imageName: "swift", toptitle: "GS더프레시 결제 시", bottomTitle: "3,000원 할인"),
    .init(imageName: "swift", toptitle: "메가MGC커피 결제 시", bottomTitle: "최대 15% 할인"),
    .init(imageName: "swift", toptitle: "독립생활 결제 시", bottomTitle: "최대 10,000원 할인"),
    .init(imageName: "swift", toptitle: "올리브영 결제할 때마다", bottomTitle: "최대 1,000P 적립"),
    .init(imageName: "swift", toptitle: "11번가 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "티몬 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "티켓링크 공연 결제 시", bottomTitle: "최대 1,000P 적립")
  ]
  
  static let dummy4: [PointPaymentRow] = [
    .init(imageName: "swift", toptitle: "IBK 계좌 페이코 충전 시", bottomTitle: "5,000P 적립"),
    .init(imageName: "swift", toptitle: "클룩 결제 시", bottomTitle: "5,000원 할인"),
    .init(imageName: "swift", toptitle: "무신사 결제 시", bottomTitle: "2% 할인"),
    .init(imageName: "swift", toptitle: "29CM 결제 시", bottomTitle: "2% 할인"),
    .init(imageName: "swift", toptitle: "에듀윌 결제 시", bottomTitle: "5,000원 할인"),
    .init(imageName: "swift", toptitle: "에버온 전기차 충전 시", bottomTitle: "최대 10,000원 할인"),
    .init(imageName: "swift", toptitle: "교보문고 결제 시 건당", bottomTitle: "5% 적립"),
    .init(imageName: "swift", toptitle: "이디야 결제 시 건당", bottomTitle: "10% 적립"),
    .init(imageName: "swift", toptitle: "AK플라자 결제 시", bottomTitle: "최대 16% 상품권 지급"),
    .init(imageName: "swift", toptitle: "GS더프레시 결제 시", bottomTitle: "3,000원 할인"),
    .init(imageName: "swift", toptitle: "메가MGC커피 결제 시", bottomTitle: "최대 15% 할인"),
    .init(imageName: "swift", toptitle: "독립생활 결제 시", bottomTitle: "최대 10,000원 할인")
  ]
}
