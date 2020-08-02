# SpriteKitMagic
A Spritekit Framework Protocol Based to make our lives easier handling gestures and motion

# How to Use it
1. Copy the "GestureManagement" group to your project
2. Create Subclasses of your SKNodes (See examples in prroject)
3. Create your GameScene as subclass of HandledGestureSKScene
3. Conform your nodes with the new Protocols listed below as you need



## Protocols
- protocol TouchableSKNode:SKNode
    - Just mark your node as touchable

- protocol TapableSKNode:TouchableSKNode
    - Mark your node as able to receive TAP gesture
        
- protocol TapableToogleSelectedSKNode:TapableSKNode
    - Executes func toogleSelected() on single tap

- protocol PannableSKNode
    - Handles PAN gesture, moving node
        
- protocol PannableLimitInScreenSKNode:PannableSKNode
    - Make the node return to first full visible position at end of PAN
        
- protocol PannableRemoveOutScreenSKNode:PannableSKNode
    - remove node from Scene if invisible at the end of TAP
        
- protocol PannableHaveInertia:PannableSKNode
    - Execute PAN inertia movement depending on pan velocity and friction parameter

- protocol ScalableSKNode:TouchableSKNode
    - Make node Pinch Scalable
    
- protocol ScalableFitScrenSKNode:ScalableSKNode
    - Reduce to Fit node in scene at the end of scale, if result is a node bigger than scene
    
- protocol ScalableFillScrenSKNode:ScalableSKNode
    - Reduce to Fill node in scene at the end of scale, if result is a node bigger than scene



## Useful functions
- UITouch & Set<UITouch> extensions
    - func firstTouchedNode<T>(of type:T.Type, in node:SKNode)->T?
	Returns first touched node of this UITouch of a Given Type or the root node of this query


- UIGestureRecognizer extensions
    - firstTouchedNode:SKNode?
	Returns first touched node of this UIGestureRecognizer
    - orientedLocation: CGPoint
    	Returns correct Y signal location
    - firstTouchedNode<T>(of type:T.Type)->T?
	Returns first touched node of this UIGestureRecognizer of a Given Type or the root node of this query
	
- SKNode extensions
    - pulse(_ times:Int = 1, duration: TimeInterval = 0.1)
    	Run a pulse animation
    - scaleValueToFitScreen:CGFloat
    - scaleValueToFillScreen:CGFloat
    - proportionToScreen:CGPoint
    - isOffScene:Bool
    - isFullOffScene:Bool
    - removeFromParentIfOffScene()
    - bounceBackIfOffScreen()
    - frameInScene:CGRect
    	A frame representant in adjusted to the scene

