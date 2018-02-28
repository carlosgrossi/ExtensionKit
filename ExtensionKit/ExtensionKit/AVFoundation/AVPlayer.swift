//
//  AVPlayer.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import AVFoundation

public extension AVPlayer {
	
	public static func backgroundVideoView(_ videoName: String, ofType: String) -> (backgroundView: UIView?, avPlayer: AVPlayer?) {
		var backgroundView: UIView?
		var avPlayer: AVPlayer?
		
		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
			try AVAudioSession.sharedInstance().setActive(true)
			guard let videoPath = Bundle.main.path(forResource: videoName, ofType: ofType) else { return (nil, nil) }
			
			let videoURL = URL(fileURLWithPath: videoPath)
			let videoAsset = AVAsset(url: videoURL)
			let avPlayerItem = AVPlayerItem(asset: videoAsset)
			
			avPlayer = AVPlayer(playerItem: avPlayerItem)
			let avPlayerLayer = AVPlayerLayer(player: avPlayer)
			
            avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
			avPlayerLayer.frame = UIScreen.main.bounds
			
			backgroundView = UIView(frame: UIScreen.main.bounds)
			backgroundView?.backgroundColor = UIColor.clear
			backgroundView?.layer.addSublayer(avPlayerLayer)
			
			avPlayer?.seek(to: kCMTimeZero)
			avPlayer?.volume = 0.0
			avPlayer?.actionAtItemEnd = AVPlayerActionAtItemEnd.none
		} catch {
		}
		return (backgroundView, avPlayer)
	}
	
}