//
//  MoveViewController.swift
//  CircleBounce
//
//  Created by Tri Dang on 10/20/19.
//  Copyright © 2019 Tri Dang. All rights reserved.
//

import UIKit

class MoveViewController: UIViewController {
    var stateController: StateController?
    var circleList = [Circle]()
    var circleMover:Timer?
    var topSafeArea: CGFloat = 0
    var bottomSafeArea: CGFloat = 0
    var initialCenter = CGPoint()
    
    @IBOutlet weak var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
        //TODO: START the motion, don't allow creation/deletion
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // we can only get the safe area AFTER the circleView has been created
        // safe area values are now available to use
        topSafeArea = view.safeAreaInsets.top
        bottomSafeArea = view.safeAreaInsets.bottom

        print("topSafeArea: \(topSafeArea)")
        print("bottomSafeArea: \(bottomSafeArea)")
        displayMoveView()
        
    }
    
    func displayMoveView() {
        circleList = stateController?.circles ?? []
        circleView.stateController = stateController
        circleView.circleList = circleList
        circleView.getData()
        
        circleView.moveCircle(top: topSafeArea, bottom: bottomSafeArea)
    }
    
    @IBAction func moveGesture(_ sender: UIPanGestureRecognizer) {
        guard sender.view! != nil else {return}
        
        let translation = sender.translation(in: sender.view!)
        switch (sender.state) {
        case .began:
            // need to start the circle
            initialCenter = sender.location(in: sender.view!)
            break
        case .ended:
            // we need to save the circle that was drawn
            moveCircle(at: initialCenter , move: translation)
            break
        default:
            break
        }
    }
    
    
    func moveCircle(at point:CGPoint, move: CGPoint) {
        let moved = stateController?.moveAt(at: point, move: move)
        circleView.getData()
        print("Moved: \(moved ?? 0)")
    }
    

}
