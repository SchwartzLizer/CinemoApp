//
//  String+Extension.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

extension String {
  func localized() -> String {
      return NSLocalizedString(self, comment: "")
  }
}
