//
//  StyleSheets.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import UIKit

// MARK: - Constants.Radius

extension Constants {
  enum Radius {
    static let cornerRadiusCard: CGFloat = 12.0
  }
}

// MARK: - Theme

enum Theme: Int {
  case LightMode, DarkMode

  // MARK: Internal

  var userInterfaceStyle: UIUserInterfaceStyle {
    switch self {
    case .LightMode: return .light
    case .DarkMode: return .dark
    }
  }

  var backgroundColor: UIColor {
    self.dynamicColor(light: .white, dark: .black)
  }

  var titleTextColor: UIColor {
    self.dynamicColor(light: .black, dark: .white)
  }

  var subtitleTextColor: UIColor {
    self.dynamicColor(light: .lightGray, dark: .lightGray)
  }

  var buttonTextColor: UIColor {
    self.dynamicColor(light: .lightGray, dark: .lightGray)
  }

  var cardBackgroundColor: UIColor {
    self.dynamicColor(light: UIColor().hex("#f8f8f8"), dark: UIColor().hex("#636363"))
  }

  var heartColor: UIColor {
    self.dynamicColor(light: UIColor().hex("#ff3144"), dark: UIColor().hex("#ff3144"))
  }

  var moonColor: UIColor {
    self.dynamicColor(light: .black, dark: .white)
  }

  var tableViewBackgroundColor: UIColor {
    self.dynamicColor(light: .white, dark: .black)
  }

  var labelHeaderTableViewColor: UIColor {
    self.dynamicColor(light: .lightGray, dark: .white)
  }

  var navigationBarTintColor: UIColor {
    self.dynamicColor(light: .black, dark: .white)
  }

  var navigationBarTitleColor: UIColor {
    self.dynamicColor(light: .black, dark: .white)
  }

  var navigationBarBackgroundColor: UIColor {
    self.dynamicColor(light: .white, dark: .black)
  }

  // MARK: Private

  private func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
    return UIColor { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .dark: return dark
      default: return light
      }
    }
  }
}


// MARK: - Fonts

enum Fonts: Int {

  case main

  // MARK: Internal

  var favoriteButtonFont: UIFont {
    switch self {
    case .main:
      return UIFont(name: Constants.Font.bold, size: 24)!
    }
  }

  var seeMoreButtonFont: UIFont {
    switch self {
    case .main:
      return UIFont(name: Constants.Font.bold, size: 14)!
    }
  }

  var titleFont: UIFont {
    switch self {
    case .main:
      return UIFont(name: Constants.Font.regular, size: 16)!
    }
  }

  var subtitleFont: UIFont {
    switch self {
    case .main:
      return UIFont(name: Constants.Font.regular, size: 14)!
    }
  }

  var searchFont: UIFont {
    switch self {
    case .main:
      return UIFont(name: Constants.Font.regular, size: 16)!
    }
  }

}

// MARK: - Height

enum Height: CGFloat {
  case header = 30.0
}
