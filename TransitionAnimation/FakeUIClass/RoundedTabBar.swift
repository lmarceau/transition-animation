//
//  RoundedTabBar.swift
//  TransitionAnimation
//
//  Created by Laurie Marceau on 2021-02-10.
//

import UIKit

class RoundedTabBar: UITabBar {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.masksToBounds = true
        self.barStyle = .default
        self.layer.cornerRadius = 32
        self.barTintColor = UIColor(red: 180/255, green: 166/255, blue: 214/255, alpha: 1.0)
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
