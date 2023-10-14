//
//  NetworkTest.swift
//  Cinemo AppTests
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import XCTest

class NetworkTest: XCTestCase {

  func testMovieList() {
    let expectation = self.expectation(description: "movieList")

    var movieList: MovieListModel?
    Network.shared.request(router: Router.movieList) { (result: Result<MovieListModel>) in
      switch result {
      case .success(let movies):
        movieList = movies
      default:
        break
      }

      expectation.fulfill()
    }

    waitForExpectations(timeout: 10, handler: nil)

    XCTAssertNotNil(movieList)
  }
}
