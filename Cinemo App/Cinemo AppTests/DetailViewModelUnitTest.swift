//
//  DetailViewModelUnitTest.swift
//  Cinemo AppTests
//
//  Created by Tanatip Denduangchai on 10/15/23.
//

import XCTest
@testable import Cinemo_App

class DetailViewModelTests: XCTestCase {

    var mockMovie: Movie!
    var viewModel: DetailViewModel!

    override func setUp() {
        super.setUp()
        self.mockMovie = Movie.mockUp1
        self.viewModel = DetailViewModel(data: self.mockMovie)
    }

    override func tearDown() {
        self.viewModel = nil
        self.mockMovie = nil
        super.tearDown()
    }

    func testCheckFavorite() {
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
