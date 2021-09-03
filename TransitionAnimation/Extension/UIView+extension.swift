//
//  UIView+extension.swift
//  TransitionAnimation
//
//  Created by Laurie Marceau on 2021-09-03.
//

import UIKit

extension UIView {
    func frameOfViewInWindowsCoordinateSystem() -> CGRect {
        if let superview = superview {
            return superview.convert(frame, to: nil)
        }
        print("Seems like this view is not in views hierarchy\n\(self)\nOriginal frame returned")
        return frame
    }

    func getSnapshot() -> UIView {
        guard let snapshot = snapshotView(afterScreenUpdates: false) else {
            fatalError("Problem with carSnapshot")
        }
        return snapshot
    }
}
