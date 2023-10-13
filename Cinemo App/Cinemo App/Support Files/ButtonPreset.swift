//
//  ButtonPreset.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit

extension UIButton {

  func applyTheme(text: String,font Font: UIFont,color Color: UIColor,round roundCorner: Bool = false,backgroundColor BackgroundColor: UIColor = .clear,borderColor BorderColor: UIColor = .clear) {
    self.setTitle(text, for: .normal)
    self.titleLabel?.font = Font
    self.setTitleColor(Color, for: .normal)
    if roundCorner {
      self.layer.cornerRadius = 12.0
    }
    self.backgroundColor = BackgroundColor
    self.layer.borderColor = BorderColor.cgColor
    self.layer.borderWidth = 1
  }

}
