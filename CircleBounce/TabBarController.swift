//
//  CircleViewDelegate.swift
//  CircleBounce
//
//  Created by Tri Dang on 10/20/19.
//  Copyright © 2019 Tri Dang. All rights reserved.
//

import Foundation
import UIKit

class TabBarDelegate: UITabBarController, UITabBarControllerDelegate {
    var stateController = StateController()
    var circleMover:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
        // allow each tab to get the same data
        guard let viewControllers = self.viewControllers else {
            print("No view controllers")
            return
        }
        guard
        let drawViewController = viewControllers[0] as? DrawViewController,
        let deleteViewController = viewControllers[1] as? DeleteViewController,
        let moveViewController = viewControllers[2] as? MoveViewController
        else {
            print("No view controllers")
            return
        }
        drawViewController.stateController = stateController
        deleteViewController.stateController = stateController
        moveViewController.stateController = stateController
        
        // we need to stop the timer when app enters background
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        // start the timer when app enters foreground
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // this is where we can call functions based on which tab was selected
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected \(viewController.title!)")
        if let title = viewController.title {
            if title == "DrawViewController" {
                stop()
                let view = viewController as? DrawViewController
                view?.draw()
            } else if title == "DeleteViewController" {
                stop()
                let view = viewController as? DeleteViewController
                view?.deleting()
            } else if title == "MoveViewController" {
                // prevent more than 1 timer to be created
                stop()
                let view = viewController as? MoveViewController
                view?.move()
                let circleView = view?.circleView
                start(circview: circleView)
            }
        }
    }
    
    // not ideal to call UIView of a UIViewController, but we need to make sure all the tabs use the same timer
    func start(circview: CircleView?) {
        if let circleView = circview {
            print("Starting motion")
            circleMover = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {circleView.updateCircle(timer: $0)})
        }
    }
    
    func stop() {
        print("Stopping motion")
        guard circleMover != nil else { return }
        circleMover!.invalidate()
        circleMover = nil
    }
    
    
    @objc func willResignActive(_ notification: Notification) {
        stop()
    }
    
    @objc func didBecomeActive(_ notification: Notification) {
        guard let viewControllers = self.viewControllers else {
            print("No view controllers")
            return
        }
        let moveViewController = viewControllers[2] as? MoveViewController
        start(circview: moveViewController?.circleView)
    }
    
}
