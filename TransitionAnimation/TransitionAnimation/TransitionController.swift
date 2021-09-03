//
//  TransitionController.swift
//  TransitionAnimation
//
//  Created by Laurie Marceau on 2021-02-10.
//

import UIKit

/// Some articles/posts that helped
/// https://medium.com/@ludvigeriksson/custom-interactive-uinavigationcontroller-transition-animations-in-swift-4-a4b5e0cefb1e
/// https://stackoverflow.com/questions/23877994/seamless-animation-from-left-to-right-when-pushing-view-controller
/// https://www.raywenderlich.com/322-custom-uiviewcontroller-transitions-getting-started
/// https://stackoverflow.com/questions/27996873/ios-swift-uiviewcontrolleranimatedtransitioning-end-frame-in-wrong-position

// This is the animator to show the secondViewController when presenting
// then animate the way back when we're moving from the secondViewController to the firstViewController
class TransitionController: NSObject, UIViewControllerAnimatedTransitioning {

    private let presenting: Bool

    init(presenting: Bool) {
        self.presenting = presenting
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presenting ? 0.3 : 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.presenting {
            animateForwardTransition(using: transitionContext)
        } else {
            animateBackwardTransition(using: transitionContext)
        }
    }
}

private extension TransitionController {

    // MARK: Forward transition (from first to second VC)

    func animateForwardTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? FirstViewController,
              let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? SecondViewController else {
            print("Problem with forward transition")
            return
        }

        self.animate(using: transitionContext,
                     fromViewController: fromViewController,
                     toViewController: toViewController,
                     completion: {
                        toViewController.transitionIsDone()
                     })
    }

    // MARK: Backward transition (from second to first VC)

    func animateBackwardTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? SecondViewController,
              let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? FirstViewController else {
            print("Problem with backward transition")
            return
        }

        fromViewController.prepareForTransitionBack {
            toViewController.prepareForTransitionBack()
            self.animate(using: transitionContext,
                         fromViewController: fromViewController,
                         toViewController: toViewController,
                         completion: {})
        }
    }

    // MARK: Animate common

    /// Animate the transition between the two VC
    func animate(using transitionContext: UIViewControllerContextTransitioning,
                 fromViewController: TransitionAnimatable,
                 toViewController: TransitionAnimatable,
                 completion: @escaping () -> Void) {

        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            print("Problem with transitionContext")
            return
        }

        // Prepare transition
        let fromVCFrame = fromView.frame
        let width = self.presenting ? fromView.frame.width : -fromView.frame.width
        let containerView = transitionContext.containerView

        if self.presenting {
            containerView.addSubview(toView)
        } else {
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        toView.frame = fromVCFrame.offsetBy(dx: width, dy: 0)

        // Take snapshots
        let snapshots = fromViewController.getPreparedSnapshots()
        toViewController.prepareForAnimation()
        for snapshot in snapshots {
            containerView.addSubview(snapshot)
        }

        // Animate objects during transition
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveLinear,
            animations: {
                toViewController.view.setNeedsLayout()
                toViewController.view.layoutIfNeeded()

                fromView.frame = fromVCFrame.offsetBy(dx: -width, dy: 0)
                toView.frame = fromVCFrame

                let positions = toViewController.getEndPositions()
                for (snapshot, position) in zip(snapshots, positions) {
                    snapshot.frame = position
                }

            }, completion: { _ in
                fromView.frame = fromVCFrame
                let success = !transitionContext.transitionWasCancelled
                if !success {
                    toView.removeFromSuperview()
                }

                fromViewController.endAnimation()
                toViewController.endAnimation()
                for snapshot in snapshots {
                    snapshot.removeFromSuperview()
                }

                transitionContext.completeTransition(success)
                completion()
            }
        )
    }
}
