//
//  EmptyStateViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import Foundation

final class EmptyStateViewModel: ViewModel {

    init(type: ErrorState) {
        self.type = type
    }

    var type: ErrorState
}
