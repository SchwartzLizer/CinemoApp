//
//  Protocol.swift
//  Template Project
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

// View
protocol Updated {
    func onInitialized()
}
protocol UserInterfaceSetup {
    func setupUI()
}
protocol Action {}
protocol ApplyTheme {
    func applyTheme()
}

// ViewModel
protocol ViewModel {}
protocol RequestService {}
protocol ProcessDataSource {}
protocol Logic {}



