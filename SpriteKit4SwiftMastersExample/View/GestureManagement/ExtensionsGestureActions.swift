//
//  GestureActionsExtensions.swift
//  SpriteKitExample
//
//  Created by Ricardo Venieris on 30/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import SpriteKit

extension UITouch {
	func firstTouchedNode<T>(of type:T.Type, in node:SKNode)->T? {
		let touchedNode = node
			.nodes(at: self.location(in: node))
			.compactMap{$0 as? T}
			.sorted{ (($0 as? SKNode)?.zPosition ?? -CGFloat.infinity) >
					 (($1 as? SKNode)?.zPosition ?? -CGFloat.infinity)}
			.first ?? (node as? T)
		return touchedNode
	}

}

extension Set where Element == UITouch {
	func firstTouchedNode<T>(of type:T.Type, in node:SKNode)->T? {
		let touchedNode = self
			.compactMap{$0.firstTouchedNode(of: T.self, in: node)}
			.sorted{ (($0 as? SKNode)?.zPosition ?? -CGFloat.infinity) >
					 (($1 as? SKNode)?.zPosition ?? -CGFloat.infinity)}
			.first ?? (node as? T)
		return touchedNode
	}
}

extension UIGestureRecognizer {
	var firstTouchedNode:SKNode? {
		let skView = self.view as? SKView
		let touchedNode =  skView?.scene?.nodes(at: orientedLocation).first
		return touchedNode
	}
	
	var orientedLocation: CGPoint {
		let maxY = self.view?.frame.maxY ?? 0
		var location = self.location(in: self.view)
		location.y = maxY - location.y
		return location
	}
	
	func firstTouchedNode<T>(of type:T.Type)->T? {
		let skView = self.view as? SKView
		let touchedNode =  skView?.scene?.nodes(at: orientedLocation).compactMap {$0 as? T}.sorted{
			(($0 as? SKNode)?.zPosition ?? -CGFloat.infinity) >
			(($1 as? SKNode)?.zPosition ?? -CGFloat.infinity)
		}.first
		return touchedNode
	}
}

extension CGRect {
	var center:CGPoint {
		return CGPoint(x: (self.origin.x + self.width)/2,
					   y: (self.origin.y + self.height)/2)
	}
}

extension SKNode {
	func pulse(_ times:Int, duration: TimeInterval) {
		self.isUserInteractionEnabled = false
		let duration = duration / TimeInterval((times*2))
		let currentScale = self.xScale
		let scaleUp = SKAction.scale(to: currentScale*1.1, duration: duration)
		let scaleBack = SKAction.scale(to: currentScale, duration: duration)
		var action:[SKAction] = []
		for _ in 0..<times {
			action.append(contentsOf: [scaleUp, scaleBack])
		}
		self.run(SKAction.sequence(action), completion: {
			self.isUserInteractionEnabled = true
		})
		
	}
	
	func pulse() {
		self.pulse(1, duration: 0.1)
	}
	
	var scaleValueToFitScreen:CGFloat {
		let scale = proportionToScreen
		return scale.x < scale.y ? scale.x : scale.y
	}
	var scaleValueToFillScreen:CGFloat {
		let scale = proportionToScreen
		return scale.x > scale.y ? scale.x : scale.y
	}
	
	var proportionToScreen:CGPoint {
		let screenSize = UIScreen.main.bounds.size
		let mySize = self.calculateAccumulatedFrame().size
		let xScale  = screenSize.width / mySize.width
		let yScale  = screenSize.height / mySize.height
		return CGPoint(x: xScale, y: yScale)
	}
	
	var isOffScene:Bool {
		guard let scene = scene else { return true }
		return	self.frame.maxX <= scene.frame.origin.x ||
			self.frame.maxY <= scene.frame.origin.y ||
			self.frame.minX >= scene.frame.maxX ||
			self.frame.minY >= scene.frame.maxY
	}
	
	var isFullOffScene:Bool {
		guard let scene = scene else { return true }
		let frame = self.frameInScene
		return	(frame.maxX <= scene.frame.origin.x || frame.maxY <= scene.frame.origin.y) &&
				(frame.minX >= scene.frame.maxX || frame.minY >= scene.frame.maxY)
	}
	
	func removeFromParentIfOffScene() {
		if self.isOffScene {
			self.removeFromParent()
		}
	}
	
	func bounceBackIfOffScreen() {
		guard let scene = scene else { return }
		let frame = self.frameInScene
		print()
		var originOff:CGPoint = (scene.frame.min - frame.min).limit(min: CGPoint.zero)
		var maxOff:CGPoint = (scene.frame.max - frame.max).limit(max: CGPoint.zero)
		
//		if	frame.size.width > scene.frame.size.width &&
//			self.isFullOffScene {
//			print(originOff.x, maxOff.x)
//			originOff.x = 0
//			maxOff.x = 0
//		}
//
		

		if	frame.size.width > scene.frame.size.width {
			switch (originOff.x > 0, maxOff.x < 0) {  // se ultrapassa nos 2 limites (maior que)
				case (true, true): // está dentro da tela
					originOff.x = 0
					maxOff.x = 0
				case (true, false): // parcialmente fora à esquerda
					originOff.x = originOff.x + (scene.frame.size.width - self.frame.size.width)
				case (false, true): // parcialmente fora à direita
					maxOff.x = maxOff.x - (scene.frame.size.width - self.frame.size.width)
				case (false, false): // completamente dentro da tela
					break
			}
		}


		if	frame.size.height > scene.frame.size.height {
			switch (originOff.y > 0, maxOff.y < 0) {  // se ultrapassa nos 2 limites (maior que)
				case (true, true): // está dentro da tela
					originOff.y = 0
					maxOff.y = 0
				case (true, false): // parcialmente fora à esquerda
					originOff.y = originOff.y + (scene.frame.size.height - self.frame.size.height)
				case (false, true): // parcialmente fora à direita
					maxOff.y = maxOff.y - (scene.frame.size.height - self.frame.size.height)
				case (false, false): // completamente dentro da tela
					break
			}
		}
		
		let offset = originOff + maxOff
		if offset != CGPoint.zero {
			let action = SKAction.move(by: offset.asCGVector, duration: 0.1)
			action.timingMode = .easeOut
			self.run(action)
		}
	}
	
	var frameInScene:CGRect {
		guard let scene = scene else { return self.frame }
		guard let parent = parent else { return self.frame }
		let original = self.position
		let relative = parent.convert(self.position, to: scene)
		var newFrame = self.frame
			newFrame.origin = newFrame.origin + (relative - original)
		return newFrame
	}
}


extension CGSize {
	func scaleFactor(to otherSize:CGSize)->CGFloat {
		
		let scaleW = self.width / otherSize.width
		let scaleH = self.height / otherSize.height
		var x = 1
		x += 1
		return (scaleW < scaleH) ? scaleW : scaleH
	}
}

extension CGPoint {
	static func * (lhs:CGPoint, rhs:CGFloat)->CGPoint {
		return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
	}
	static func + (lhs:CGPoint, rhs:CGPoint)->CGPoint {
		return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}
	static func - (lhs:CGPoint, rhs:CGPoint)->CGPoint {
		return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}
	
	func limit(min:CGPoint? = nil, max:CGPoint? = nil)->CGPoint {
		var newValue = self
		if let min = min {
			newValue.x = newValue.x > min.x ? newValue.x : min.x
			newValue.y = newValue.y > min.y ? newValue.y : min.y
		}
		if let max = max {
			newValue.x = newValue.x < max.x ? newValue.x : max.x
			newValue.y = newValue.y < max.y ? newValue.y : max.y
		}
		return newValue
	}
	
	var asCGVector:CGVector {
		return CGVector(dx: self.x, dy: self.y)
	}
}

extension CGRect {
	var max:CGPoint {
		return CGPoint(x: self.maxX, y: self.maxY)
	}
	var min:CGPoint {
		return CGPoint(x: self.minX, y: self.minY)
	}
}


