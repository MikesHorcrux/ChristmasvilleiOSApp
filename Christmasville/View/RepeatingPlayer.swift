//
//  RepeatingPlayer.swift
//  Christmasville
//
//  Created by Mike on 7/16/23.
//

import SwiftUI
import AVKit
import AVFoundation

#if os(iOS)
struct RepeatingPlayer: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<RepeatingPlayer>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}

class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let fileUrl = Bundle.main.url(forResource: "animated-christmas-wish-card-background-with-lollipop-and-snowy-trees-falling-snow--SBV-338943138-HD", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer()
        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

#endif

#if os(macOS)
struct RepeatingPlayer: NSViewRepresentable {
    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<RepeatingPlayer>) {
    }

    func makeNSView(context: Context) -> NSView {
        return LoopingPlayerNSView(frame: .zero)
    }
}

class LoopingPlayerNSView: NSView {
    private var playerView: AVPlayerView
    private var playerLooper: AVPlayerLooper?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        self.playerView = AVPlayerView()
        super.init(frame: frame)
        
        let fileUrl = Bundle.main.url(forResource: "animated-christmas-wish-card-background-with-lollipop-and-snowy-trees-falling-snow--SBV-338943138-HD", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer(playerItem: item)
        player.isMuted = true
        playerView.player = player
        playerView.controlsStyle = .none
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()

        addSubview(playerView)
    }
    
    override func layout() {
        super.layout()

        playerView.frame = bounds

        guard let player = playerView.player else {
            return
        }

        let videoSize: CGSize = player.currentItem?.asset.tracks(withMediaType: .video).first?.naturalSize ?? self.bounds.size
        let viewRatio: CGFloat = self.bounds.width / self.bounds.height
        let videoRatio: CGFloat = videoSize.width / videoSize.height
        var newSize: CGSize = .zero

        if videoRatio < viewRatio {
            newSize.width = self.bounds.width
            newSize.height = self.bounds.width / videoRatio
        } else {
            newSize.height = self.bounds.height
            newSize.width = self.bounds.height * videoRatio
        }

        let x = (self.bounds.width - newSize.width) / 2
        let y = (self.bounds.height - newSize.height) / 2
        playerView.frame = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
    }

}
#endif
