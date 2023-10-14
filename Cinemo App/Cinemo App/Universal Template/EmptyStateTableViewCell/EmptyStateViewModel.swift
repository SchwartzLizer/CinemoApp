//
//  EmptyStateViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import Foundation

final class EmptyStateViewModel: ViewModel {

    init(type: EmptyStateType) {
        self.type = type
    }

    enum EmptyStateType:String {
        case searchNotFound = "Search_Not_Found"
        case serviceNotFound = "Service_Not_Found"
    }

    var type: EmptyStateType
}
