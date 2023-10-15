//
//  DetailViewModelUnitTest.swift
//  Cinemo AppTests
//
//  Created by Tanatip Denduangchai on 10/15/23.
//

import XCTest
@testable import Cinemo_App

class DetailViewModelTests: XCTestCase {

    // Mock movie data
    var mockMovie: Movie!

    // ViewModel instance
    var viewModel: DetailViewModel!

    override func setUp() {
        super.setUp()

        // Setting up mock data. Use the necessary initializer or static method to create your Movie instance
        self.mockMovie = Movie.mockUp1

        // Initialize ViewModel with mock data
        self.viewModel = DetailViewModel(data: self.mockMovie)
    }

    override func tearDown() {
        self.viewModel = nil
        self.mockMovie = nil
        super.tearDown()
    }

    func testCheckFavorite() {
        // Assuming UserDefault().getFavorite() works and gets movies from UserDefaults
        // If "Mock Movie" is a favorite, isAlreadyFav should be true
        UserDefault().addFavorite(data: self.mockMovie)
        self.viewModel.checkFavourite()
        XCTAssertEqual(self.viewModel.isAlreadyFav, true, "Expected isAlreadyFav to be true for mock movie.")
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
