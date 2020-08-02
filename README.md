# SpriteKitMagic
A Spritekit Framework Protocol Based to make our lives easier handling gestures and motion

# How to Use it
1. Copy the "GestureManagement" group to your project
2. Create Subclasses of your SKNodes (See examples in prroject)
3. Create your GameScene as subclass of HandledGestureSKScene
3. Conform your nodes with the new Protocols listed below as you need

Protocols

// MARK: Touch
protocol TouchableSKNode:SKNode {}

// MARK: Tap managemenet
protocol TapableSKNode:TouchableSKNode {}
protocol TapableToogleSelectedSKNode:TapableSKNode {
	func toogleSelected()
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
