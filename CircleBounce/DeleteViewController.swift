//
//  DeleteViewController.swift
//  CircleBounce
//
//  Created by Tri Dang on 10/20/19.
//  Copyright © 2019 Tri Dang. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {
    var stateController: StateController?
    var circleList = [Circle]()
    
    @IBOutlet weak var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        displayDeleteView()
        
        //TODO: Allow deletion, STOP the motion, and don't allow creation
    }

    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        guard sender.view != nil else { return }
             
        if sender.state == .ended {      // Move the view down and to the right when tapped.
            let tap = sender.location(in: sender.view)
            print(tap)
            deleteCircle(at: tap)
        }
    }
        
    func displayDeleteView() {
        circleList = stateController?.circles ?? []
        circleView.stateController = stateController
        circleView.circleList = circleList
        circleView.getData()
    }
    
    func deleteCircle(at point: CGPoint) {
        let deleted = stateController?.deleteAt(at: point)
        print("Deleted: \(deleted ?? 0)")
        circleView.deletedCircle()
    }

}

