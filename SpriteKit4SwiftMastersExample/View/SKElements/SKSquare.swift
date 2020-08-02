//
//  SKSquare.swift
//  SpriteKitExample
//
//  Created by Ricardo Venieris on 30/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import SpriteKit


class SKSquare:SKSpriteNode, ScalableSKNode, PannableSKNode, RotatableSKNode {
	
	init() {
		
		let color = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 0.5)
		super.init(texture: nil, color: color, size: CGSize(width: 300, height: 300))
		
		self.name = "Square"
		self.isUserInteractionEnabled = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
