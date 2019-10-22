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
    var x:CGFloat
    var y:CGFloat
    var deltaX:CGFloat
    var deltaY:CGFloat
    var radius:CGFloat
    var color:CGColor
    
    init(x:CGFloat, y:CGFloat, dx:CGFloat, dy:CGFloat, rad:CGFloat, color:CGColor) {
        self.x = x
        self.y = y
        self.deltaX = dx
        self.deltaY = dy
        self.radius = rad
        self.color = color
    }
    
    mutating func setXY(x:CGFloat, y:CGFloat) {
        self.x = x
        self.y = y
    }
    
    mutating func setDelta(dx:CGFloat, dy:CGFloat) {
        self.deltaX = dx
        self.deltaY = dy
    }
    
    func contains(point: CGPoint) -> Bool{
        let centerX = self.x + self.radius
        let centerY = self.y + self.radius
        if ((point.x - centerX) * (point.x - centerX) + (point.y - centerY) * (point.y - centerY)) <= radius*radius {
            print("Inside circle")
            return true
        } else {
            return false
        }
    }
    
    func toString() -> String {
        return "x: \(x) | y: \(y) | dx: \(deltaX) | dy: \(deltaY) | radius: \(radius)"
    }
    
    static func ==(lhs: Circle, rhs: Circle) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.radius == rhs.radius
    }
    
}
