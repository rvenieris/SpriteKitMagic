//
//  SKMoulding.swift
//  SpriteKit4SwiftMastersExample
//
//  Created by Ricardo Venieris on 31/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import SpriteKit


class SKMoulding:SKShapeNode, PannableSKNode {

	init(thickness thick:CGFloat) {
		 
		super.init()
		let myPath = CGMutablePath()
		let center = UIScreen.main.bounds.center
		let extra: CGFloat = 0
		// Quadrado de dentro
		let x1 = [center.x - UIScreen.main.bounds.origin.x + extra,
				  center.x - UIScreen.main.bounds.maxX - extra]
		let y1 = [center.y - UIScreen.main.bounds.origin.y + extra,
				  center.y - UIScreen.main.bounds.maxY - extra]
		// Quadrado de fora
		let x2 = [center.x - UIScreen.main.bounds.origin.x + thick - extra,
				  center.x - UIScreen.main.bounds.maxX - thick + extra]
		let y2 = [center.y - UIScreen.main.bounds.origin.y + thick - extra,
				  center.y - UIScreen.main.bounds.maxY - thick + extra]
		let points:[CGPoint] = [
			CGPoint(x: x1[0], y: y1[0]),
			CGPoint(x: x1[1], y: y1[0]),
			CGPoint(x: x1[1], y: y1[1]),
			CGPoint(x: x1[0], y: y1[1]),
			CGPoint(x: x1[0], y: y1[0]),

			CGPoint(x: x2[0], y: y2[0]),
			CGPoint(x: x2[1], y: y2[0]),
			CGPoint(x: x2[1], y: y2[1]),
			CGPoint(x: x2[0], y: y2[1]),
			CGPoint(x: x2[0], y: y2[0])

		]
		
		myPath.addLines(between: points)
		path = myPath
		self.fillColor = .blue
		self.isUserInteractionEnabled = true
		self.name = "quadro"
		
		//		let x = NSAttributedStringd
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		touches.firstTouchedNode(of: TouchableSKNode.self, in: self)?.pulse()
	}

	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
