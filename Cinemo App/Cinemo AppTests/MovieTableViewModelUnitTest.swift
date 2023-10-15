//
//  MovieTableViewModelUnitTest.swift
//  Cinemo AppTests
//
//  Created by Tanatip Denduangchai on 10/15/23.
//

import XCTest
@testable import Cinemo_App

class MovieTableViewModelTests: XCTestCase {
    var viewModel: MovieTableViewModel!
    var movieData: Movie!

    override func setUpWithError() throws {
        self.movieData = Movie.mockUp1
        self.viewModel = MovieTableViewModel(data: self.movieData)
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        self.movieData = nil
    }

    func testInitCheckFavourite_IsFav() {
        // Given
        UserDefault().addFavorite(data: self.movieData)

        // When
        self.viewModel.checkFavourite()

        // Then
        XCTAssertTrue(self.viewModel.isAlreadyFav)
    }

    func testInitCheckFavourite_IsNotFav() {
        // Given
        UserDefault().removeFavorite(data: self.movieData)

        // When
        self.viewModel.checkFavourite()

        // Then
        XCTAssertFalse(self.viewModel.isAlreadyFav)
    }

    func testUpdateFavorite() {
        // Add the mock movie to favorites
        self.viewModel.updateFavourite()

        XCTAssertTrue(self.viewModel.isAlreadyFav, "Expected isAlreadyFav to be true after adding to favorites.")

        // Remove the mock movie from favorites
        self.viewModel.updateFavourite()

        XCTAssertFalse(self.viewModel.isAlreadyFav, "Expected isAlreadyFav to be false after removing from favorites.")
    }
}
