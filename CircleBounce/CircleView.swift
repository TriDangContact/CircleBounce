//
//  CircleView.swift
//  CircleBounce
//
//  Created by Tri Dang on 10/20/19.
//  Copyright © 2019 Tri Dang. All rights reserved.
//

import UIKit

class CircleView: UIView {

//    weak var delegate:CircleViewDelegate?
    var stateController:StateController?
    var circleList = [Circle]()
    var topSafeArea: CGFloat = 0
    var bottomSafeArea: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            for circle in circleList {
                let circleBoundary = CGRect(x: circle.centerX, y: circle.centerY, width: circle.radius*2, height: circle.radius*2)
                context.addEllipse(in: circleBoundary)
                context.setFillColor(UIColor.blue.cgColor)
                context.drawPath(using: .eoFill)
            }
        }
    }
    
    func getData() {
        if let state = stateController {
            circleList = state.circles
            setNeedsDisplay()
        }
    }
    
    func atDraw() {
        if let state = stateController {
            print("At Draw")
        }
    }
    func atDelete() {
        print("At Delete")
        if let state = stateController {
        }
    }
    func atMove(top:CGFloat, bottom:CGFloat) {
        print("At Move")
        if let state = stateController {
            topSafeArea = top
            bottomSafeArea = bottom
        }
    }
    
    func updateCircle(timer:Timer) {
        for index in 0..<circleList.count {
            edgeDetection(index: index)
            circleList[index].centerX += circleList[index].deltaX
            circleList[index].centerY += circleList[index].deltaY
            
            // need to save the data each time it was moved
            stateController?.circles = circleList
            setNeedsDisplay()
        }
    }
    
    func edgeDetection(index: Int) {
        let circle = circleList[index]
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        let left = circle.centerX
        let right = circle.centerX + (circle.radius*2)
        let top = circle.centerY
        let bottom = circle.centerY + (circle.radius*2)
        
        //circle width
        if (left < 0) || (right > viewWidth) {
            circleList[index].deltaX = -1 * circleList[index].deltaX
        }
        //circle height, we need to also take into account safe area
        if (top < (0 + topSafeArea)) || (bottom > (viewHeight - bottomSafeArea)) {
            circleList[index].deltaY = -1 * circleList[index].deltaY
        }
    }

}
