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
    
    @IBOutlet weak var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        circleList = stateController?.circles ?? []
        circleView.stateController = stateController
        circleView.circleList = circleList
        
        draw()
        
        //TODO: Allow creation, STOP the motion, and don't allow deletion
    }

    func draw() {
        circleView.getData()
        circleView.atDraw()
    }
    
    
    
    
    
    

}

