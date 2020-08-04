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
		

		let mapamundi = SKManageableImageNode(imageNamed: "mapamundi")
		mapamundi.position = self.frame.center
		mapamundi.zPosition = 0
		self.addChild(mapamundi)


//		let quadrado = SKMoulding(thickness: -30)
//		quadrado.position = self.frame.center
//		quadrado.zPosition = -CGFloat.infinity
//		self.addChild(quadrado)
//
//		let intherain = SKManageableImageNode(imageNamed: "intherain")
//		intherain.position = self.frame.center
//		intherain.zPosition = 0
//		quadrado.addChild(intherain)

		var bolinaDeGolfe:SKMyCircle {
			let bolinaDeGolfe = SKMyCircle(radius: 200)
		bolinaDeGolfe.position = self.frame.center
		bolinaDeGolfe.zPosition = 1
			bolinaDeGolfe.alpha = 0.7
			return bolinaDeGolfe
		}
		
		let bola1 = bolinaDeGolfe
		self.addChild(bola1)
		
		let bola2 = bolinaDeGolfe
		bola2.position.x += 100
		self.addChild(bola2)
		
//		self.addChild(bolinaDeGolfe)
//		self.addChild(bolinaDeGolfe)

		
    }
	
}
