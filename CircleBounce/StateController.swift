//
//  StateController.swift
//  CircleBounce
//
//  Created by Tri Dang on 10/20/19.
//  Copyright © 2019 Tri Dang. All rights reserved.
//

import Foundation
import UIKit

class StateController {
    let speedDivider:CGFloat = 100
    var circles: [Circle] = [
        Circle(x:0, y:50, dx:1, dy:0, rad: 50, color:UIColor.black.cgColor),
        Circle(x:0, y:150, dx:0, dy:1, rad: 50, color:UIColor.blue.cgColor),
        Circle(x:0, y:250, dx:1, dy:1, rad: 50, color:UIColor.red.cgColor)
    ]
//    var circles = [Circle]()
        
    func indexOf(circle: Circle) -> Int{
        var index = 0
        for cir in circles {
            if cir == circle {
                return index
            }
            index+=1
        }
        return -1
    }
    
    func deleteAt(at point: CGPoint) -> Int {
        var deleted = 0
        let found = findAll(at: point)
        for circle in found {
            let index = indexOf(circle: circle)
            circles.remove(at: index)
            deleted+=1
        }
        return deleted
    }
    
    // need to figure out
    func moveAt(at point:CGPoint, move:CGPoint) -> Int {
        var moved = 0
        let found = findAll(at: point)
        for circle in found {
            let index = indexOf(circle: circle)
            // we control how much velocity of the gesture should be reflected
            circles[index].setDelta(dx: (move.x/speedDivider), dy: (move.y/speedDivider))
            moved+=1
        }
        return moved
    }
    
    func findAll(at point: CGPoint) -> [Circle] {
        var found = [Circle]()
        for circle in circles {
            if circle.contains(point: point) {
                found.append(circle)
            }
        }
        return found
    }
    
    func add(circle: Circle) -> Bool {
        circles.append(circle)
        return true
    }

}
