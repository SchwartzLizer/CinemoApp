//
//  HomeSceneUITests.swift
//  Cinemo AppUITests
//
//  Created by Tanatip Denduangchai on 10/15/23.
//

import XCTest

final class HomeSceneUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // Instantiate a new XCUIApplication and launch.
        self.app = XCUIApplication()
        self.app.launch()
    }

    func waitForElementToDisappear(element: XCUIElement, timeout: TimeInterval = 5) {
        // Define the expectation for waiting for the element to disappear.
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: element)

        // Wait for the expectation to fulfill.
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)

        // Optional: Check the result if needed.
        if result != .completed {
            // Handle the timeout or failure as you wish.
            XCTFail("Failed waiting for element to disappear")
        }
    }


    func testHomeViewControllerElementsExist() {
        // Wait for Lottie animation to disappear.
        let lottieView = self.app.otherElements[Constants.AccessibilityIdentifier.loadingView]
        self.waitForElementToDisappear(element: lottieView)

        // Ensure that the search bar exists.
        let searchBar = self.app.otherElements[Constants.AccessibilityIdentifier.HomeViewController.homeSearchBar]
        XCTAssertTrue(searchBar.exists, "Search bar does not exist.")

        // Ensure that the table view exists.
        let tableView = self.app.tables[Constants.AccessibilityIdentifier.HomeViewController.homeTableView]
        XCTAssertTrue(tableView.exists, "Table view does not exist.")
    }

    func testTableCellElementsExist() {
        // Wait for Lottie animation to disappear.
        let lottieView = self.app.otherElements[Constants.AccessibilityIdentifier.loadingView]
        self.waitForElementToDisappear(element: lottieView)

        // Ensure that the table view exists.
        let tableView = self.app.tables[Constants.AccessibilityIdentifier.HomeViewController.homeTableView]
        XCTAssertTrue(tableView.exists, "Table view does not exist.")

        // Ensure that the first cell exists.
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First cell does not exist.")

        // Ensure that the first cell's title label exists.
        let firstCellTitleLabel = firstCell.staticTexts[Constants.AccessibilityIdentifier.MovieTableViewCell.movieTitleLabel]
        XCTAssertTrue(firstCellTitleLabel.exists, "First cell's title label does not exist.")

        // Ensure that the first cell's image view exists.
        let firstCellImageView = firstCell.images[Constants.AccessibilityIdentifier.MovieTableViewCell.movieImageView]
        XCTAssertTrue(firstCellImageView.exists, "First cell's image view does not exist.")

        // Ensure that the first cell's release date label exists.
        let firstCellReleaseDateLabel = firstCell.staticTexts[Constants.AccessibilityIdentifier.MovieTableViewCell.movieReleaseDateLabel]
        XCTAssertTrue(firstCellReleaseDateLabel.exists, "First cell's release date label does not exist.")

        // Ensure that the first cell's genre label exists.
        let firstCellGenreLabel = firstCell.staticTexts[Constants.AccessibilityIdentifier.MovieTableViewCell.moviegenreLabel]
        XCTAssertTrue(firstCellGenreLabel.exists, "First cell's genre label does not exist.")

        // Ensure that the first cell's see more button exists.
        let firstCellSeeMoreButton = firstCell.buttons[Constants.AccessibilityIdentifier.MovieTableViewCell.movieSeeMoreButton]
        XCTAssertTrue(firstCellSeeMoreButton.exists, "First cell's see more button does not exist.")

        // Ensure that the first cell's favorite button exists.
        let firstCellFavoriteButton = firstCell.buttons[Constants.AccessibilityIdentifier.MovieTableViewCell.movieFavoriteButton]
        XCTAssertTrue(firstCellFavoriteButton.exists, "First cell's favorite button does not exist.")
    }

    func testFavourtieButtonInCell() {
        // Wait for Lottie animation to disappear.
        let lottieView = self.app.otherElements[Constants.AccessibilityIdentifier.loadingView]
        self.waitForElementToDisappear(element: lottieView)

        // Ensure that the table view exists.
        let tableView = self.app.tables[Constants.AccessibilityIdentifier.HomeViewController.homeTableView]
        XCTAssertTrue(tableView.exists, "Table view does not exist.")

        // Ensure that the first cell exists.
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First cell does not exist.")

        // Ensure that the first cell's favorite button exists.
        let firstCellFavoriteButton = firstCell.buttons[Constants.AccessibilityIdentifier.MovieTableViewCell.movieFavoriteButton]
        XCTAssertTrue(firstCellFavoriteButton.exists, "First cell's favorite button does not exist.")

        // Tap on the favorite button.
        firstCellFavoriteButton.tap()

        // Ensure that the favorite button is now selected.
        XCTAssertTrue(firstCellFavoiriteButton.isSelected, "Favorite button is not selected.")

        // Tap on the favorite button again.
        firstCellFavoriteButton.tap()

        // Ensure that the favorite button is now not selected.
        XCTAssertFalse(firstCellFavoriteButton.isSelected, "Favorite button is selected.")
    }


}
