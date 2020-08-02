//
//  SKMyCircle.swift
//  SpriteKitExample
//
//  Created by Ricardo Venieris on 30/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import SpriteKit

class SKMyCircle:	SKShapeNode,
					ScalableFillScrenSKNode,
					PannableSKNode,
					RotatableSKNode,
					PannableHaveInertia,
					PannableRemoveOutScreenSKNode,
					PannableLimitInScreenSKNode,
					TapableToogleSelectedSKNode
{
	init(radius:CGFloat = 100) {
		super.init()
		let myPath = CGMutablePath()
		myPath.addEllipse(in: CGRect(x: -radius/2, y: -radius/2, width: radius, height: radius))
		path = myPath
		self.fillColor = .blue
		self.isUserInteractionEnabled = true
		self.name = "BolineaDeGolfe"
		
	}
	private lazy var selectedFrame:SKNode = {
		let sf = SKSpriteNode(color: .red, size: self.frame.size)
		self.alpha = 0.3
		return sf
	}()
	
	func toogleSelected() {
		if let _ = selectedFrame.parent {
			selectedFrame.removeFromParent()
		} else {
			self.addChild(selectedFrame)
		}
	}
	
	

	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
