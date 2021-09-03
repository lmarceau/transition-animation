//
//  FirstViewController.swift
//  TransitionAnimation
//
//  Created by Laurie Marceau on 2021-02-10.
//

import UIKit

class FirstViewController: UIViewController, TransitionAnimatable {

    @IBOutlet weak var runnerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var awesomeCellImageView: UIImageView!
    @IBOutlet weak var skylineCellImageView: UIImageView!
    @IBOutlet weak var morningCellImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureListenerOnFakeCells()
        navigationController?.title = "First view"
        title = "First view"
    }

    func getPreparedSnapshots() -> [UIView] {
        return [getPreparedSnapshot(imageView: runnerImageView),
                getPreparedSnapshot(imageView: awesomeCellImageView),
                getPreparedSnapshot(imageView: skylineCellImageView),
                getPreparedSnapshot(imageView: morningCellImageView)]

    }

    func getEndPositions() -> [CGRect] {
        return [
            runnerImageView.frameOfViewInWindowsCoordinateSystem(),
            awesomeCellImageView.frameOfViewInWindowsCoordinateSystem(),
            skylineCellImageView.frameOfViewInWindowsCoordinateSystem(),
            morningCellImageView.frameOfViewInWindowsCoordinateSystem()
        ]
    }

    func setImagesVisibility(isHidden: Bool) {
        runnerImageView.isHidden = isHidden
        awesomeCellImageView.isHidden = isHidden
        skylineCellImageView.isHidden = isHidden
        morningCellImageView.isHidden = isHidden
    }

    func prepareForTransitionBack() {
        tabBarController?.tabBar.isHidden = false
    }
}

private extension FirstViewController {
    func addGestureListenerOnFakeCells() {
        addGesture(imageView: awesomeCellImageView, action: #selector(awesomeTapDetected))
        addGesture(imageView: skylineCellImageView, action: #selector(skylineTapDetected))
        addGesture(imageView: morningCellImageView, action: #selector(morningTapDetected))
    }

    func addGesture(imageView: UIImageView, action: Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }

    @objc func awesomeTapDetected() {
        print("Awesome imageview clicked")
        showSecondViewController()
    }

    @objc func skylineTapDetected() {
        print("Skyline imageview clicked")
        showSecondViewController()
    }

    @objc func morningTapDetected() {
        print("Morning imageview clicked")
        showSecondViewController()
    }

    func showSecondViewController() {
        guard let navigationController = self.navigationController else {
            print("Error - Navigation controller wasn't there")
            return
        }

        let secondVC  = storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
        DispatchQueue.main.async {
            navigationController.pushViewController(secondVC!, animated: true)
        }
    }
}

