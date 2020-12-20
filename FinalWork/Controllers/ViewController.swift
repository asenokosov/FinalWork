//
//  ViewController.swift
//  FinalWork
//
//  Created by Uzver on 18.12.2020.
//

import UIKit
import AVKit

class ViewController: UIViewController {
	
	var videoPlayer: AVPlayer?
	var videoPlayerLayer: AVPlayerLayer?
	private var looper: AVPlayerLooper?
	
	@IBOutlet weak var signUpButton: UIButton!
	@IBOutlet weak var loginButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		signUpElements()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		setUpVideo()
	}
	
	func signUpElements() {
		Utilities.styleFilledButton(signUpButton)
		Utilities.styleHollowButton(loginButton)
	}
	
	func setUpVideo() {
		let bundlePath = Bundle.main.path(forResource: "Dog179", ofType: "mp4")
		
		guard bundlePath != nil else { return }
		
		let url = URL(fileURLWithPath: bundlePath!)
		let item = AVPlayerItem(url: url)
		
		videoPlayer = AVPlayer(playerItem: item)
		videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
		videoPlayerLayer?.frame = CGRect(
			x: -self.view.frame.size.width*1.5,
			y: 0,
			width: self.view.frame.width*4,
			height: self.view.frame.height)
		view.layer.insertSublayer(videoPlayerLayer!, at: 0)
		videoPlayer?.playImmediately(atRate: 0.6)
	}
}
