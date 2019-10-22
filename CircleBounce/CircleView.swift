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
    var currentColor = UIColor.black
    var initialLocation = CGPoint(x:0, y:0)
    var size:CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            for circle in circleList {
                let circleBoundary = CGRect(x: circle.x, y: circle.y, width: circle.radius*2, height: circle.radius*2)
                context.addEllipse(in: circleBoundary)
                context.setFillColor(circle.color)
                context.drawPath(using: .eoFill)
//                print("Existing circles")
            }
            // drawing the circle in Draw Mode
            let circleBoundary = CGRect(x: initialLocation.x-size, y: initialLocation.y-size, width: size*2, height: size*2)
            context.addEllipse(in: circleBoundary)
            context.setFillColor(currentColor.cgColor)
            context.drawPath(using: .eoFill)
//            print("Creating circle")
//             need to also draw the circle when it's being created
        }
    }
    
    func getData() {
        if let state = stateController {
            circleList = state.circles
            setNeedsDisplay()
        }
    }
    
    func resetCreateCircle() {
        initialLocation = CGPoint(x:0, y:0)
        size = 0
    }
    
    func createCircle(from: CGPoint, size: CGFloat, color:UIColor) {
        if let state = stateController {
            print("At Draw")
            self.currentColor = color
            self.initialLocation = from
            self.size = size
            getData()
        }
    }
    func deletedCircle() {
        if let state = stateController {
            print("At Delete")
            getData()
        }
    }
    func moveCircle(top:CGFloat, bottom:CGFloat) {
        print("At Move")
        if let state = stateController {
            topSafeArea = top
            bottomSafeArea = bottom
        }
    }
    
    func updateCircle(timer:Timer) {
        for index in 0..<circleList.count {
            edgeDetection(index: index)
            circleList[index].x += circleList[index].deltaX
            circleList[index].y += circleList[index].deltaY
            
            // need to save the data each time it was moved
            stateController?.circles = circleList
            setNeedsDisplay()
        }
    }
    
    func edgeDetection(index: Int) {
        let circle = circleList[index]
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        let left = circle.x
        let right = circle.x + (circle.radius*2)
        let top = circle.y
        let bottom = circle.y + (circle.radius*2)
        
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
