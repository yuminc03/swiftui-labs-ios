//
//  RepresentedPlayerView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 1/21/24.
//

import SwiftUI
import AVKit

struct RepresentedPlayerView: UIViewRepresentable {
  func makeUIView(context: Context) -> some UIView {
    return UIView()
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    
  }
}

final class VideoPlayerView: UIView {
  private var player = AVPlayer()
  private var playerItem: AVPlayerItem?
  private var playerLayer: AVPlayerLayer?
  
  init(videoName: String) {
    guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
      fatalError("Video Not Found.")
    }
    
    self.playerItem = .init(url: URL(filePath: path))
    self.player.replaceCurrentItem(with: playerItem)
    let playerLayer = AVPlayerLayer(player: player)
    self.playerLayer = playerLayer
    super.init(frame: .zero)
    
    layer.addSublayer(playerLayer)
  }
  
  required init?(coder: NSCoder) {
    fatalError("Do not use Storyboard.")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer?.frame = bounds
  }
}
