//
//  ASVideoContainer.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import Foundation
import AVFoundation

class ASVideoContainer {
    var url: String
    var playOn: Bool {
        didSet {
            player.isMuted = ASVideoPlayerController.sharedVideoPlayer.mute
            playerItem.preferredPeakBitRate = ASVideoPlayerController.sharedVideoPlayer.preferredPeakBitRate
            if playOn && playerItem.status == .readyToPlay {
                player.play()
            }
            else{
                player.pause()
            }
        }
    }
    
    let player: AVPlayer
    let playerItem: AVPlayerItem
    
    init(player: AVPlayer, item: AVPlayerItem, url: String) {
        self.player = player
        self.playerItem = item
        self.url = url
        playOn = false
    }
}
