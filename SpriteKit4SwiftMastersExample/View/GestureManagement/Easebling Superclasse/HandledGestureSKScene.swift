//
//  HandledGestureSKScene.swift
//  SpriteKitExample
//
//  Created by Ricardo Venieris on 30/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import Foundation


import SpriteKit
import GameplayKit



class HandledGestureSKScene: SKScene, UIGestureRecognizerDelegate {
	
	var singleTapGesture = UITapGestureRecognizer()
	var panGesture = UIPanGestureRecognizer()
	var pinchGesture = UIPinchGestureRecognizer()
	var rotateGesture = UIRotationGestureRecognizer()
	
	var lastTouchedNode:SKNode?
	var originalPinchScale:CGFloat = 1
	var originalPanPosition:CGPoint = CGPoint.zero
	var timeOfLastGestureChange:Date = Date()
	
	// MARK: Setup
	override func didMove(to view: SKView) {
		
		singleTapGesture.addTarget(self, action: #selector(self.singleTapGestureAction(_:)))
		singleTapGesture.delegate = self
		singleTapGesture.numberOfTapsRequired = 1
		view.addGestureRecognizer(singleTapGesture)
		
		panGesture.addTarget(self, action: #selector(self.panGestureAction(_:)))
		panGesture.delegate = self
		view.addGestureRecognizer(panGesture)
		
		pinchGesture.addTarget(self, action: #selector(self.pinchGestureAction(_:)))
		pinchGesture.delegate = self
		view.addGestureRecognizer(pinchGesture)
		
		rotateGesture.addTarget(self, action: #selector(self.rotateGestureAction(_:)))
		rotateGesture.delegate = self
		view.addGestureRecognizer(rotateGesture)
		
	}
	
	
	@objc func singleTapGestureAction(_ sender: UITapGestureRecognizer) {
		lastTouchedNode =  lastTouchedNode ??
			sender.firstTouchedNode(of: TapableSKNode.self)
		handle(singleTap: sender)
	}
	
	@objc func panGestureAction(_ sender: UIPanGestureRecognizer) {
		lastTouchedNode =  lastTouchedNode ??
			sender.firstTouchedNode(of: PannableSKNode.self)
		handle(pan: sender)
	}
	
	@objc func pinchGestureAction(_ sender: UIPinchGestureRecognizer) {
		lastTouchedNode =  lastTouchedNode ??
			sender.firstTouchedNode(of: ScalableSKNode.self)
		handle(pinch: sender)
		
	}
	
	@objc func rotateGestureAction(_ sender: UIRotationGestureRecognizer) {
		lastTouchedNode =  lastTouchedNode ??
			sender.firstTouchedNode(of: RotatableSKNode.self)
		handle(rotation: sender)
	}
	
	
	func handle(singleTap gesture: UITapGestureRecognizer) {
		switch gesture.state {
			case .ended:
				(lastTouchedNode as? TapableToogleSelectedSKNode)?.toogleSelected()
			lastTouchedNode = nil
			default: // ended, cancelled, etc
				break
		}
		timeOfLastGestureChange = Date()
	}
	
	func handle(pan gesture: UIPanGestureRecognizer) {
		var translation = gesture.translation(in: self.view)
		translation.y = -translation.y
		switch gesture.state {
			
			case .began:
				originalPanPosition = lastTouchedNode?.position ?? originalPanPosition
			case .changed:
				(lastTouchedNode as? PannableSKNode)?.move(to: originalPanPosition+translation)
			default: // ended, cancelled, etc
				(lastTouchedNode as? PannableHaveInertia)?.applyInertia(for: gesture.velocity(in: self.view), and: timeOfLastGestureChange)
				(lastTouchedNode as? PannableLimitInScreenSKNode)?.bounceBackIfOffScreen()
				lastTouchedNode = nil			
		}
		timeOfLastGestureChange = Date()
	}
	
	func handle(pinch gesture:UIPinchGestureRecognizer) {
		switch gesture.state {
			case .began:
				self.originalPinchScale = lastTouchedNode?.xScale ?? 1
			case .changed:
				(lastTouchedNode as? ScalableSKNode)?.setScale(using: originalPinchScale, adding: gesture.scale)
				
			default: // ended, cancel, etc
				if lastTouchedNode is ScalableFitScrenSKNode &&
				   lastTouchedNode is ScalableFillScrenSKNode {
					fatalError("node \(lastTouchedNode?.name ?? "without name") cannot be ScalableFitScrenSKNode & ScalableFillScrenSKNode at the same time")
				}
				(lastTouchedNode as? ScalableFitScrenSKNode)?.scaleUpScreen()
				(lastTouchedNode as? ScalableFillScrenSKNode)?.scaleUpScreen()
				lastTouchedNode = nil
				originalPinchScale = 1
		}
	}
	
	func handle(rotation gesture: UIRotationGestureRecognizer) {
		let rotation = gesture.rotation
		switch gesture.state {
			case .began:
				break
			case .changed:
				self.lastTouchedNode?.zRotation = -rotation
			case .ended:
				lastTouchedNode = nil
			default:
				return
		}
	}
	
}
