//
//  ThemeManager.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit

extension UIColor {
  func hex(_ hex: String) -> UIColor {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }

    guard cString.count == 6, let rgbValue = UInt32(cString, radix: 16) else {
      return UIColor.gray
    }

    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: 1.0)
  }
}

// MARK: - Theme

enum Theme: Int {

  case LightMode, DarkMode

  // MARK: Internal

  var mainColor: UIColor {
    switch self {
    case .LightMode:
      return UIColor().hex("ffffff")
    case .DarkMode:
      return UIColor().hex("000000")
    }
  }

  // Customizing the Navigation Bar
  var barStyle: UIBarStyle {
    switch self {
    case .LightMode:
      return .default
    case .DarkMode:
      return .black
    }
  }

  var navigationBackgroundImage: UIImage? {
    return self == .LightMode ? UIImage(named: "navBackground") : nil
  }

  var tabBarBackgroundImage: UIImage? {
    return self == .LightMode ? UIImage(named: "tabBarBackground") : nil
  }

  var backgroundColor: UIColor {
    switch self {
    case .LightMode:
      return UIColor().hex("ffffff")
    case .DarkMode:
      return UIColor().hex("000000")
    }
  }

  var secondaryColor: UIColor {
    switch self {
    case .LightMode:
      return UIColor().hex("ffffff")
    case .DarkMode:
      return UIColor().hex("000000")
    }
  }

  var titleTextColor: UIColor {
    switch self {
    case .LightMode:
      return .black
    case .DarkMode:
      return .black
    }
  }

  var subtitleTextColor: UIColor {
    switch self {
    case .LightMode:
      return .lightGray
    case .DarkMode:
      return .lightGray
    }
  }

  var buttonTextColor: UIColor {
    switch self {
    case .LightMode:
      return .lightGray
    case .DarkMode:
      return .lightGray
    }
  }

  var cardBackgroundColor: UIColor {
    switch self {
    case .LightMode:
      return UIColor().hex("#f8f8f8")
    case .DarkMode:
      return UIColor().hex("#f8f8f8")
    }
  }



}

// Enum declaration
let SelectedThemeKey = "LightMode"

// MARK: - ThemeManager

// This will let you use a theme in the app.
enum ThemeManager {

  // ThemeManager
  static func currentTheme() -> Theme {
    if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
      return Theme(rawValue: storedTheme)!
    } else {
      return .DarkMode
    }
  }

}

