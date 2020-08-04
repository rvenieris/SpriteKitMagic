//
//  GestureActionsProtocol.swift
//  SpriteKitExample
//
//  Created by Ricardo Venieris on 30/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import SpriteKit

// MARK: Touch
protocol TouchableSKNode:SKNode {}

// MARK: Tap managemenet
protocol TapableSKNode:TouchableSKNode {}
protocol TapableToggleSelectedSKNode:TapableSKNode {
	func toggleSelected()
}

// MARK: Pan managemenet
protocol PannableSKNode:TouchableSKNode {}
protocol PannableLimitInScreenSKNode:PannableSKNode {
	func bounceBackIfOffScreen()
}
protocol PannableRemoveOutScreenSKNode:PannableSKNode {}
protocol PannableHaveInertia:PannableSKNode{}

// MARK: Scale managemenet
protocol ScalableSKNode:TouchableSKNode {}
protocol ScalableFitScrenSKNode:ScalableSKNode {
	func scaleUpScreen()
}
protocol ScalableFillScrenSKNode:ScalableSKNode {
	func scaleUpScreen()
}

// MARK: Rotation managemenet
protocol RotatableSKNode:SKNode {}

// MARK: Default Implementations
extension PannableSKNode {
	func move(to position: CGPoint ) {
		let animation = SKAction.move(to: position, duration: 0.1)
		self.run(animation, completion: {
			(self as? PannableRemoveOutScreenSKNode)?.removeFromParentIfOffScene()
		})
	}
}

extension PannableHaveInertia {
	func applyInertia(for velocity:CGPoint, and lastMoveTime:Date, timingFunction: SKTimingFunction = .easeOutQuad, friction:CGFloat = 10) {
		guard lastMoveTime.timeIntervalSinceNow.magnitude < 0.1 else {return}
		
		let duration = Double(velocity.x.magnitude + velocity.y.magnitude) / 2000
		let animation = SKAction.move(by: CGVector(dx: velocity.x/friction, dy: -velocity.y/friction), duration: duration)
		animation.timingFunction = timingFunction.function
		self.run(animation, completion: {
			(self as? PannableRemoveOutScreenSKNode)?.removeFromParentIfOffScene()
			(self as? PannableLimitInScreenSKNode)?.bounceBackIfOffScreen()
		})
	}
}


extension ScalableSKNode {
	func setScale(using originalScale: CGFloat, adding scale:CGFloat) {
		let newScale = originalScale * scale
		let animation = SKAction.scale(to: newScale, duration: 0.1)
		self.run(animation)
	}
}

extension ScalableFitScrenSKNode {
	func scaleUpScreen() {
		self.scaleUpScreen(3)
	}
	private func scaleUpScreen(_ retries:Int) {
		guard scaleValueToFitScreen > self.xScale &&
		      scaleValueToFitScreen > self.yScale else {return}
		let animation = SKAction.scale(by: scaleValueToFitScreen, duration: 0.1)
		self.run(animation, completion: {
			if self.scaleValueToFitScreen > 1 && retries > 0 {
				self.scaleUpScreen(retries-1)
			} else {
				(self as? PannableLimitInScreenSKNode)?.bounceBackIfOffScreen()
			}
		})
	}
}

extension ScalableFillScrenSKNode {
	func scaleUpScreen() {
		self.scaleUpScreen(3)
	}
	private func scaleUpScreen(_ retries:Int) {
		guard scaleValueToFillScreen > self.xScale ||
			  scaleValueToFillScreen > self.yScale else {return}
		let animation = SKAction.scale(by: scaleValueToFillScreen, duration: 0.1)
		self.run(animation, completion: {
			if self.scaleValueToFillScreen > 1 && retries > 0 {
				self.scaleUpScreen(retries-1)
			} else {
				(self as? PannableLimitInScreenSKNode)?.bounceBackIfOffScreen()
			}
		})
	}
	
}
