//
//  StateController.swift
//  CircleBounce
//
//  Created by Tri Dang on 10/20/19.
//  Copyright © 2019 Tri Dang. All rights reserved.
//

import Foundation

class StateController {
    var circles: [Circle] = [
        Circle(x:0, y:50, dx:1, dy:0, rad: 50),
        Circle(x:0, y:150, dx:0, dy:1, rad: 50),
        Circle(x:0, y:250, dx:1, dy:1, rad: 50),
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
    
    // need to implement try block
    func add(circle: Circle) -> Bool {
        circles.append(circle)
        return true
    }
    
    // temporary remove function
    func remove(index: Int) -> Circle{
        circles.remove(at: index)
    }
    
}
