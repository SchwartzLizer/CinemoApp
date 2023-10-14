//
//  AppUtility.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/15/23.
//

import Foundation

class AppUtility {
    func toggleMode() {
        if
            let storedThemeRawValue = UserDefaults.standard.value(forKey: SelectedThemeKey) as? Int,
            let currentTheme = Theme(rawValue: storedThemeRawValue)
        {
            switch currentTheme {
            case .LightMode:
                StyleSheetManager.applyTheme(theme: .DarkMode)
            case .DarkMode:
                StyleSheetManager.applyTheme(theme: .LightMode)
            }
        } else {
            StyleSheetManager.applyTheme(theme: .LightMode)
        }
    }
}
