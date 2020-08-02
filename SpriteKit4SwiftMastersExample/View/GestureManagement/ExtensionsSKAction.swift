//
//  ExtensionsSKAction.swift
//  SpriteKit4SwiftMastersExample
//
//  Created by Ricardo Venieris on 02/08/20.
//  Copyright © 2020 Ricardo Venieris. All rights reserved.
//

import SpriteKit
//

enum SKTimingFunction {
	// no easing, no acceleration
	case easeLinear
	// accelerating from zero velocity
	case easeInQuad
	// decelerating to zero velocity
	case easeOutQuad
	// acceleration until halfway, then deceleration
	case easeInOutQuad
	// accelerating from zero velocity
	case easeInCubic
	// decelerating to zero velocity
	case easeOutCubic
	// acceleration until halfway, then deceleration
	case easeInOutCubic
	// accelerating from zero velocity
	case easeInQuart
	// decelerating to zero velocity
	case easeOutQuart
	// acceleration until halfway, then deceleration
	case easeInOutQuart
	// accelerating from zero velocity
	case easeInQuint
	// decelerating to zero velocity
	case easeOutQuint
	// acceleration until halfway, then deceleration
	case easeInOutQuint
	// accelerating Sin
	case easeInSin
	
	case easeOutSin
	
	case easeInOutSin
	// elastic bounce effect at the beginning
	case easeInElastic
	// elastic bounce effect at the end
	case easeOutElastic
	// elastic bounce effect at the beginning and end
	case easeInOutElastic
	
	var function:SKActionTimingFunction {
		switch self {
			case .easeLinear:
				return Function.easeLinear
			case .easeInQuad:
				return Function.easeInQuad
			case .easeOutQuad:
				return Function.easeOutQuad
			case .easeInOutQuad:
				return Function.easeInOutQuad
			case .easeInCubic:
				return Function.easeInCubic
			case .easeOutCubic:
				return Function.easeOutCubic
			case .easeInOutCubic:
				return Function.easeInOutCubic
			case .easeInQuart:
				return Function.easeInQuart
			case .easeOutQuart:
				return Function.easeOutQuart
			case .easeInOutQuart:
				return Function.easeInOutQuart
			case .easeInQuint:
				return Function.easeInQuint
			case .easeOutQuint:
				return Function.easeOutQuint
			case .easeInOutQuint:
				return Function.easeInOutQuint
			case .easeInSin:
				return Function.easeInSin
			case .easeOutSin:
				return Function.easeOutSin
			case .easeInOutSin:
				return Function.easeInOutSin
			case .easeInElastic:
				return Function.easeInElastic
			case .easeOutElastic:
				return Function.easeOutElastic
			case .easeInOutElastic:
				return Function.easeInOutElastic
		}
	}
	
	private class Function {
		
		// no easing, no acceleration
		static var easeLinear: SKActionTimingFunction = {
			var t: Float = $0
			return t
		}
		
		// accelerating from zero velocity
		static var easeInQuad: SKActionTimingFunction = {
			var t: Float = $0
			return t*t
		}
		
		// decelerating to zero velocity
		static var easeOutQuad: SKActionTimingFunction = {
			var t: Float = $0
			return t*(2-t)
		}
		
		// acceleration until halfway, then deceleration
		static var easeInOutQuad: SKActionTimingFunction = {
			var t: Float = $0
			return t<0.5 ? 2*t*t : -1+(4-2*t)*t
		}
		
		// accelerating from zero velocity
		static var easeInCubic: SKActionTimingFunction = {
			var t: Float = $0
			return t*t*t
		}
		
		// decelerating to zero velocity
		static var easeOutCubic: SKActionTimingFunction = {
			var t: Float = $0
			return (t - 1)*t*t+1
		}
		
		// acceleration until halfway, then deceleration
		static var easeInOutCubic: SKActionTimingFunction = {
			var t: Float = $0
			return t<0.5 ? 4*t*t*t : (t-1)*(2*t-2)*(2*t-2)+1
		}
		
		// accelerating from zero velocity
		static var easeInQuart: SKActionTimingFunction = {
			var t: Float = $0
			return t*t*t*t
		}
		
		// decelerating to zero velocity
		static var easeOutQuart: SKActionTimingFunction = {
			var t: Float = $0
			return 1-(t-1)*t*t*t
		}
		
		// acceleration until halfway, then deceleration
		static var easeInOutQuart: SKActionTimingFunction = {
			var t: Float = $0
			return t<0.5 ? 8*t*t*t*t : 1-8*(t-1)*t*t*t
		}
		
		// accelerating from zero velocity
		static var easeInQuint: SKActionTimingFunction = {
			var t: Float = $0
			return t*t*t*t*t
		}
		
		// decelerating to zero velocity
		static var easeOutQuint: SKActionTimingFunction = {
			var t: Float = $0
			return 1+(t-1)*t*t*t*t
		}
		
		// acceleration until halfway, then deceleration
		static var easeInOutQuint: SKActionTimingFunction = {
			var t: Float = $0
			return t<0.5 ? 16*t*t*t*t*t : 1+16*(t-1)*t*t*t*t
		}
		
		static var easeInSin: SKActionTimingFunction = {
			var t: Float = $0
			return 1 + sin(Float.pi / 2 * t - Float.pi / 2)
		}
		
		static var easeOutSin : SKActionTimingFunction = {
			var t: Float = $0
			return sin(Float.pi / 2 * t)
		}
		
		static var easeInOutSin: SKActionTimingFunction = {
			var t: Float = $0
			return (1 + sin(Float.pi * t - Float.pi / 2)) / 2
		}
		
		// elastic bounce effect at the beginning
		static var easeInElastic: SKActionTimingFunction = {
			var t: Float = $0
			return (0.04 - 0.04 / t) * sin(25 * t) + 1
		}
		
		// elastic bounce effect at the end
		static var easeOutElastic: SKActionTimingFunction = {
			var t: Float = $0
			return 0.04 * t / (t - 1) * sin(25 * t)
		}
		
		// elastic bounce effect at the beginning and end
		static var easeInOutElastic: SKActionTimingFunction = {
			var t: Float = $0
			return (t < 0.5) ? (0.01 + 0.01 / t) * sin(50 * t) : (0.02 - 0.01 / t) * sin(50 * t) + 1
		}
		
	}
}
