//
//  TransitionNavigationController.swift
//  TransitionAnimation
//
//  Created by Laurie Marceau on 2021-02-10.
//

import UIKit

class TransitionNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        // helps shadow animation in the nav bar
        view.backgroundColor = UIColor.white
    }
}

extension TransitionNavigationController: UINavigationControllerDelegate {
    internal func navigationController(_ navigationController: UINavigationController,
                                       animationControllerFor operation: UINavigationController.Operation,
                                       from fromVC: UIViewController,
                                       to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionController(presenting: operation == .push)
    }
}
