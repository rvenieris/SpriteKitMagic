//
//  SKLabelBoladao.swift
//  SpriteKitExample
//
//  Created by Ricardo Venieris on 29/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import SpriteKit

class SKManageableImageNode:SKSpriteNode,
							ScalableFillScrenSKNode,
							PannableSKNode,
//							RotatableSKNode,
							PannableHaveInertia,
							PannableLimitInScreenSKNode
{
	
	init(imageNamed: String) {
		let texture = SKTexture(imageNamed: imageNamed)
		print(texture.size())
		super.init(texture: texture, color: .red, size: texture.size())
		self.name = imageNamed
		self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		self.isUserInteractionEnabled = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.pulse()
	}
	
}
