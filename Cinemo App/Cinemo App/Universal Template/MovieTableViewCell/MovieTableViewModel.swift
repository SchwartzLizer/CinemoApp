//
//  MovieTableViewModel.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

// MARK: - MovieTableViewModel

class MovieTableViewModel: ViewModel {

    // MARK: Lifecycle

    init(data: Movie) {
        self.data = data
        checkFavourite()
    }

    // MARK: Internal

    let data: Movie

    // MARK: Private

    public var isAlreadyFav: Bool = false
    var onUpdated: (() -> Void)?

}

extension MovieTableViewModel: ProcessDataSource {
    func checkFavourite() {
        isAlreadyFav = false
        UserDefault().getFavorite().forEach { movie in
            if movie.id == self.data.id {
                self.isAlreadyFav = true
            }
        }
    }
}

// MARK: Logic

extension MovieTableViewModel: Logic {
    func updateFavourite() {
        if self.isAlreadyFav == true {
            self.isAlreadyFav = false
            UserDefault().removeFavorite(data: self.data)
        } else {
            self.isAlreadyFav = true
            UserDefault().addFavorite(data: self.data)
        }
        self.onUpdated?()
    }

}
