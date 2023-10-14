//
//  ButtonPreset.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit

extension UIButton {

  func applyTheme(
    text: String,
    font Font: UIFont,
    color Color: UIColor,
    round roundCorner: Double = 0,
    backgroundColor BackgroundColor: UIColor = .clear,
    borderColor BorderColor: UIColor = .clear)
  {
    self.setTitle(text, for: .normal)
    self.titleLabel?.font = Font
    self.setTitleColor(Color, for: .normal)
    self.layer.cornerRadius = roundCorner
    self.backgroundColor = BackgroundColor
    self.layer.borderColor = BorderColor.cgColor
    self.layer.borderWidth = 1
  }

}
