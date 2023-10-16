//
//  EmptyStateViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import Foundation

final class EmptyStateViewModel: ViewModel {

    // MARK: Lifecycle

    init(type: ErrorState) {
        self.type = type
    }

    // MARK: Public

    public var type: ErrorState
}
