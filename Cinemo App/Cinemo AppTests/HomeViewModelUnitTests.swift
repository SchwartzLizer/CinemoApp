//
//  HomeViewModelUnitTests.swift
//  Cinemo AppTests
//
//  Created by Tanatip Denduangchai on 10/15/23.
//

import XCTest
import Combine
@testable import Cinemo_App

class HomeViewModelUnitTests: XCTestCase {
    var viewModel: HomeViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        self.viewModel = HomeViewModel()
        self.cancellables = []
    }

    override func tearDown() {
        self.viewModel = nil
        self.cancellables = nil
        super.tearDown()
    }

    func testInitialStates() {
        XCTAssertFalse(self.viewModel.isSearching)
        XCTAssertEqual(self.viewModel.movieList.value, [])
        XCTAssertEqual(self.viewModel.searchQueryList.value, [])
        XCTAssertEqual(self.viewModel.errorState.value, .none)
    }

    func testRequestMovieListSuccess() {
        self.viewModel.requestMovieList()
    }

    func testSearchWithNonEmptyQuery() {
        let movie1 = Movie.mockUp1
        let movie2 = Movie.mockUp2
        self.viewModel.movieList.send([movie1, movie2])

        self.viewModel.searchMovieList(query: "Tay")

        XCTAssertTrue(self.viewModel.isSearching)
        XCTAssertEqual(self.viewModel.searchQueryList.value.count, 2)
    }

    func testSearchWithExactQuery() {
        let movie1 = Movie.mockUp1
        let movie2 = Movie.mockUp2
        self.viewModel.movieList.send([movie1, movie2])
        self.viewModel.searchMovieList(query: "Taylor Swift")

        XCTAssertTrue(self.viewModel.isSearching)
        XCTAssertEqual(self.viewModel.searchQueryList.value.count, 1)
    }

    func testSearchWithEmptyQuery() {
        self.viewModel.searchText.send("")

        XCTAssertFalse(self.viewModel.isSearching)
        XCTAssertEqual(self.viewModel.searchQueryList.value, [])
        XCTAssertEqual(self.viewModel.errorState.value, .none)
    }
}
