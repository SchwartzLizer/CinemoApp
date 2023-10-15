//
//  AccessibilityIdentifier.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/15/23.
//

import Foundation

extension Constants {
    enum AccessibilityIdentifier {
        enum HomeViewController {
            static let homeSearchBar = "homeSearchBar"
            static let homeTableView = "homeTableView"
        }

        static let loadingView = "loadingView"

        enum MovieTableViewCell {
            static let movieTitleLabel = "movieTitleLabel"
            static let movieImageView = "movieImageView"
            static let movieReleaseDateLabel = "movieReleaseDateLabel"
            static let moviegenreLabel = "moviegenreLabel"
            static let movieSeeMoreButton = "movieSeeMoreButton"
            static let movieFavoriteButton = "movieFavoriteButton"
            static let movieLottieFavoriteButton = "movieLottieFavoriteButton"
            static let movieCardView = "movieCardView"
        }
    }
}
