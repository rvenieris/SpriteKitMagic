//
//  GameScene.swift
//  SpriteKitExample
//
//  Created by Ricardo Venieris on 29/07/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: HandledGestureSKScene {
	

	// MARK: Setup
    override func didMove(to view: SKView) {
		super.didMove(to: view)
		
		let quadrado = SKMoulding(thickness: -30)
		quadrado.position = self.frame.center
		quadrado.zPosition = -CGFloat.infinity
		self.addChild(quadrado)
		
		let intherain = SKManageableImageNode(imageNamed: "intherain")
		intherain.position = self.frame.center
		intherain.zPosition = 0
		quadrado.addChild(intherain)

		var bolinaDeGolfe:SKMyCircle {
			let bolinaDeGolfe = SKMyCircle(radius: 200)
		bolinaDeGolfe.position = self.frame.center
		bolinaDeGolfe.zPosition = 1
			bolinaDeGolfe.alpha = 0.7
			return bolinaDeGolfe
		}
		self.addChild(bolinaDeGolfe)
		self.addChild(bolinaDeGolfe)
		self.addChild(bolinaDeGolfe)
		self.addChild(bolinaDeGolfe)

		
    }
	
}
