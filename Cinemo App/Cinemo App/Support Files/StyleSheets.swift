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

    var backgroundColor: UIColor {
        switch self {
        case .LightMode:
            return .white
        case .DarkMode:
            return .black
        }
    }

    var titleTextColor: UIColor {
        switch self {
        case .LightMode:
            return .black
        case .DarkMode:
            return .white
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
            return UIColor().hex("#636363")
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

    var tableViewBackgroundColor: UIColor {
        switch self {
        case .LightMode:
            return .white
        case .DarkMode:
            return .black
        }
    }

    var labelHeaderTableViewColor: UIColor {
        switch self {
        case .LightMode:
            return .lightGray
        case .DarkMode:
            return .white
        }
    }

    var navigationBarTintColor: UIColor {
        switch self {
        case .LightMode:
            return .black
        case .DarkMode:
            return .white
        }
    }

    var navigationBarTitleColor: UIColor {
        switch self {
        case .LightMode:
            return .black
        case .DarkMode:
            return .white
        }
    }

    var navigationBarBackgroundColor: UIColor {
        switch self {
        case .LightMode:
            return .white
        case .DarkMode:
            return .black
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
