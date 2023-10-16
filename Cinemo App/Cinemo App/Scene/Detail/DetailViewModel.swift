//
//  DetailViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import Foundation

// MARK: - DetailViewModel

final class DetailViewModel: ViewModel {

    // MARK: Lifecycle

    init(data: Movie) {
        self.data = data
        checkFavourite()
    }

    // MARK: Public

    public var isAlreadyFav = false
    public var onUpdated: (() -> Void)?

    // MARK: Internal

    private(set) var data: Movie

}

// MARK: ProcessDataSource

extension DetailViewModel: ProcessDataSource {
    private func checkFavourite() {
        self.isAlreadyFav = false
        UserDefault().getFavorite().forEach { movie in
            if movie.id == self.data.id {
                self.isAlreadyFav = true
            }
        }
    }

}

// MARK: Logic

extension DetailViewModel:Logic {
    public func updateFavourite() {
        if self.isAlreadyFav == true {
            self.isAlreadyFav = false
            UserDefault().removeFavorite(data: self.data)
            AlertUtility.showAlert(
                title: Constants.Keys.appName.localized(),
                message: (self.data.titleEn ?? "") + "\n" + Constants.Keys.removeFavourite.localized())
        } else {
            self.isAlreadyFav = true
            UserDefault().addFavorite(data: self.data)
            AlertUtility.showAlert(
                title: Constants.Keys.appName.localized(),
                message: (self.data.titleEn ?? "") + "\n" + Constants.Keys.addFavourite.localized())
        }
        self.onUpdated?()
    }
}
