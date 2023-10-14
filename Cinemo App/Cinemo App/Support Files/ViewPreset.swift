//
//  ViewPreset.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit

extension UIView {
  func applyTheme(background: UIColor, radius: CGFloat) {
    self.backgroundColor = background
    self.layer.borderColor = UIColor.clear.cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = radius
  }
}
