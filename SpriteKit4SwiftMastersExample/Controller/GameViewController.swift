//
//  GameViewController.swift
//  SpriteKitExample
//
//  Created by Ricardo Venieris on 29/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()

		let gameScene:GameScene = {
			let scene = GameScene(size: UIScreen.main.bounds.size)
			scene.scaleMode = .aspectFill
			return scene
		}()
		
		if let view = self.view as! SKView? {
			// Load the SKScene from 'GameScene.sks'
			//SKScene(fileNamed: "GameScene.sks")
			
			// Present the scene
			view.presentScene(gameScene)
			view.ignoresSiblingOrder = true
			view.showsFPS = true
			view.showsNodeCount = true
		}
	}
	
	
//	@objc
//	func pinchGestureAction(_ sender: UIPinchGestureRecognizer) {
//		gameScene.pinchGestureAction(sender)
//	}
//
//	@objc
//	func panGestureAction(_ sender: UIPanGestureRecognizer) {
//		gameScene.panGestureAction(sender)
//	}
//

	override var shouldAutorotate: Bool {
		return true
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		if UIDevice.current.userInterfaceIdiom == .phone {
			return .allButUpsideDown
		} else {
			return .all
		}
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
}
