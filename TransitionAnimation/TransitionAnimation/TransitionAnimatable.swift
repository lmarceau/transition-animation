//
//  TransitionAnimatable.swift
//  TransitionAnimation
//
//  Created by Laurie Marceau on 2021-09-03.
//

import UIKit

protocol TransitionAnimatable: UIViewController {
    // Preparation
    func prepareForAnimation()
    func getPreparedSnapshots() -> [UIView]

    // Finishing animation
    func endAnimation()
    func getEndPositions() -> [CGRect]
    func setImagesVisibility(isHidden: Bool)
}

extension TransitionAnimatable {
    func getPreparedSnapshot(imageView: UIImageView) -> UIView {
        let snapshot = imageView.getSnapshot()
        snapshot.frame = imageView.frameOfViewInWindowsCoordinateSystem()
        imageView.isHidden = true
        return snapshot
    }

    func prepareForAnimation() {
        setImagesVisibility(isHidden: true)
    }

    func endAnimation() {
        setImagesVisibility(isHidden: false)
    }
}
