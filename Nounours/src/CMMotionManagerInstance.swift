//
//  CMMotionManagerInstance.swift
//  Nounours
//
//  Created by Carmen Alvarez on 01/10/2018.
//  Copyright © 2018 Carmen Alvarez. All rights reserved.
//

import CoreMotion
class CMMotionManagerInstance : NSObject {
	@objc
	static let shared = CMMotionManager()
}
