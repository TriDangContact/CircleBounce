//
//  DrawViewController.swift
//  CircleBounce
//
//  Created by Tri Dang on 10/20/19.
//  Copyright © 2019 Tri Dang. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    var stateController: StateController?
    var circleList = [Circle]()
    
    var initialCenter = CGPoint()
    var currentColor = UIColor.black
    
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var createCircleView: UIImageView!
    @IBOutlet weak var instructionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        displayDrawView()
        
        //TODO: Allow creation, STOP the motion, and don't allow deletion
    }

    @IBAction func colorBtn(_ sender: UIButton) {
        guard let color = sender.titleColor(for: .normal) else {
            return
        }
        currentColor = color
        var image:UIImage?
        switch currentColor {
        case UIColor.black:
            currentColor = UIColor.blue
            image = UIImage(named: "blue-circle")
            break
        case UIColor.blue:
            currentColor = UIColor.red
            image = UIImage(named: "red-circle")
            break
        case UIColor.red:
            currentColor = UIColor.black
            image = UIImage(named: "black-circle")
        default:
            currentColor = UIColor.black
        }
        sender.setTitleColor(currentColor, for: .normal)
        sender.setImage(image, for: .normal)
        
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        guard sender.view! != nil else {return}
        let piece = sender.view!
        var size:CGFloat = 0
        let translation = sender.translation(in: piece)
        switch (sender.state) {
        case .began:
            // need to start the circle
            initialCenter = sender.location(in: piece)
            print("initialCenter: \(initialCenter)")
            break
        case .changed:
            // we need to draw as it expands
            size = abs(max(translation.x, translation.y))
            drawCircle(from: initialCenter, size: size)
            print("Size: \(size)")
            break
        case .ended:
            // we need to save the circle that was drawn
            let newCenter = sender.location(in: piece)
            size = abs(max(translation.x, translation.y))
            print("newCenter: \(newCenter)")
            saveCircle(from: initialCenter, size: size)
            circleView.resetCreateCircle()
            displayDrawView()
            break
        default:
            break
        }
    }
    
    func displayDrawView() {
        circleList = stateController?.circles ?? []
        circleView.stateController = stateController
        circleView.circleList = circleList
        if (circleList.count == 0) {
            instructionText.isHidden = false
        } else {
            instructionText.isHidden = true
        }
        
        circleView.getData()
    }
    
    func drawCircle(from: CGPoint, size: CGFloat) {
        circleView.createCircle(from: from, size: size, color: currentColor)
    }
    
    func saveCircle(from:CGPoint, size:CGFloat) {
        // we need to subtract size from center, size UIView draws it from top-left corner
        let circle = Circle(x: from.x-size, y: from.y-size, dx: 0, dy: 0, rad: size, color: currentColor.cgColor)
        print(circle.toString())
        stateController?.add(circle: circle)
    }
    

    
    
    
    
    

}

