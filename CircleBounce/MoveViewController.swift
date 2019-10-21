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
    
    @IBOutlet weak var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        circleList = stateController?.circles ?? []
        circleView.stateController = stateController
        circleView.circleList = circleList
    
        //TODO: START the motion, don't allow creation/deletion
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // we can only get the safe area AFTER the circleView has been created
        topSafeArea = view.safeAreaInsets.top
        bottomSafeArea = view.safeAreaInsets.bottom

        print("topSafeArea: \(topSafeArea)")
        print("bottomSafeArea: \(bottomSafeArea)")
        move()
        // safe area values are now available to use
    }
    
    func move() {
        circleView.getData()
        circleView.atMove(top: topSafeArea, bottom: bottomSafeArea)
    }
    

}
