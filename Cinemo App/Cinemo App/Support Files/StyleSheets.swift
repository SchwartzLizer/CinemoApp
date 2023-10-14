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

    var heartColor: UIColor {
        switch self {
        case .LightMode:
            return UIColor().hex("#ff3144")
        case .DarkMode:
            return UIColor().hex("#ff3144")
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


}