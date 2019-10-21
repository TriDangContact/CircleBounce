//
//  Circle.swift
//  CircleBounce
//
//  Created by Tri Dang on 10/20/19.
//  Copyright © 2019 Tri Dang. All rights reserved.
//

import Foundation
import UIKit

struct Circle: Equatable {
    var centerX:CGFloat
    var centerY:CGFloat
    var deltaX:CGFloat
    var deltaY:CGFloat
    var radius:CGFloat
    
    init(x:CGFloat, y:CGFloat, dx:CGFloat, dy:CGFloat, rad:CGFloat) {
        centerX = x
        centerY = y
        deltaX = dx
        deltaY = dy
        radius = rad
    }
    
    mutating func setX(x:CGFloat) {
        self.centerX = x
    }
    mutating func setY(y:CGFloat) {
        self.centerY = y
    }
    mutating func setDX(dx:CGFloat) {
        self.deltaX = dx
    }
    mutating func setDY(dy:CGFloat) {
        self.deltaY = dy
    }
    
    func toString() -> String {
        return "x: \(centerX) | y: \(centerY) | dx: \(deltaX) | dy: \(deltaY) | radius: \(radius)"
    }
    
    static func ==(lhs: Circle, rhs: Circle) -> Bool {
        return lhs.centerX == rhs.centerX && lhs.centerY == rhs.centerY && lhs.radius == rhs.radius
    }
    
}
