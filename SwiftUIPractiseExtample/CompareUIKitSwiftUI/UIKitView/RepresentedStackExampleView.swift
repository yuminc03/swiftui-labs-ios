//
//  StackExampleView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 9/21/25.
//

import UIKit
import SwiftUI

struct RepresentedStackExampleView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return StackExampleView()
  }
  
  func updateUIView(_ uiView: UIView, context: Context) { }
}

final class StackExampleView: UIView {
  private let stackView: UIStackView = {
    let v = UIStackView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.axis = .vertical
    v.spacing = 20
    
    return v
  }()
  
  private let imageView: UIImageView = {
    let v = UIImageView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.image = UIImage(systemName: "swift")
    v.contentMode = .scaleAspectFit
    v.tintColor = .systemRed
    
    return v
  }()
  
  private let titleLabel: UILabel = {
    let v = UILabel()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.font = .systemFont(ofSize: 32, weight: .bold)
    v.textAlignment = .center
    v.text = "Answer : Love Myself"
    
    return v
  }()
  
  private let messageLabel: UILabel = {
    let v = UILabel()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.font = .systemFont(ofSize: 20)
    v.numberOfLines = 0
    v.text = "시작의 처음부터 끝의 마지막까지 해답은 오직 하나 왜 자꾸만 감추려고만 해 니 가면 속으로\n내 실수로 생긴 흉터까지 다 내 별자린데 You've shown me I have reasons I should love myself 내 숨 내 걸어온 길 전부로 답해"
    
    return v
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setupUI()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("Do not use Storyboard.")
  }
  
  private func setupUI() {
    addSubview(stackView)
    
    [imageView, titleLabel, messageLabel].forEach {
      stackView.addArrangedSubview($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
    
    imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
  }
}
