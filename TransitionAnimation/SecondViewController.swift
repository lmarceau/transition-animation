//
//  SecondViewController.swift
//  TransitionAnimation
//
//  Created by Laurie Marceau on 2021-02-10.
//

import UIKit

class SecondViewController: UIViewController, TransitionAnimatable {

    @IBOutlet weak var runnerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    /// Faking some UI cells that transitions into this view controller
    @IBOutlet weak var animatedAwesomeCellImageView: UIImageView!
    @IBOutlet weak var animatedSkylineCellImageView: UIImageView!
    @IBOutlet weak var animatedMorningCellImageView: UIImageView!
    @IBOutlet weak var animatedAwesomeCellConstraint: NSLayoutConstraint!
    @IBOutlet weak var animatedSkylineCellConstraint: NSLayoutConstraint!
    @IBOutlet weak var animatedMorningCellConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomDrawerConstraint: NSLayoutConstraint!
    @IBOutlet weak var threeTieredViewConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Second view"
    }

    func getPreparedSnapshots() -> [UIView] {
        return [getPreparedSnapshot(imageView: runnerImageView),
                getPreparedSnapshot(imageView: animatedAwesomeCellImageView),
                getPreparedSnapshot(imageView: animatedSkylineCellImageView),
                getPreparedSnapshot(imageView: animatedMorningCellImageView)]

    }

    func getEndPositions() -> [CGRect] {
        return [
            runnerImageView.frameOfViewInWindowsCoordinateSystem(),
            animatedAwesomeCellImageView.frameOfViewInWindowsCoordinateSystem(),
            animatedSkylineCellImageView.frameOfViewInWindowsCoordinateSystem(),
            animatedMorningCellImageView.frameOfViewInWindowsCoordinateSystem()
        ]
    }

    func transitionIsDone() {
        animate(isForward: true, completion: {})
        tabBarController?.tabBar.isHidden = true
    }

    func prepareForTransitionBack(completion: @escaping () -> Void) {
        animate(isForward: false, completion: completion)
    }

    func setImagesVisibility(isHidden: Bool) {
        runnerImageView.isHidden = isHidden
        animatedAwesomeCellImageView.isHidden = isHidden
        animatedSkylineCellImageView.isHidden = isHidden
        animatedMorningCellImageView.isHidden = isHidden
    }
}

private extension SecondViewController {
    func animate(isForward: Bool, completion: @escaping () -> Void) {
        // Will animate the three cells
        animatedAwesomeCellConstraint.constant = isForward ? -500 : -150
        animatedSkylineCellConstraint.constant = isForward ? -570 : -230
        animatedMorningCellConstraint.constant = isForward ? -640 : -300

        // Will animate the secondVC components
        bottomDrawerConstraint.constant = isForward ? -80 : -310
        threeTieredViewConstraint.constant = isForward ? 35 : -300

        UIView.animate(withDuration: isForward ? 0.2 : 0.3,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.view.layoutIfNeeded()
                       }) { _ in
            completion()
        }
    }
}
