//
//  CharactersViewControllerTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import XCTest
@testable import StoneChallenge

class CharactersViewControllerTests: XCTestCase {

    func testCharactersViewControllerInit() throws {

        // Arrange
        let presenter: CharactersPresenter = .mock()

        // Act
        let viewController = CharactersViewController(
            viewModelProvider: presenter
        )

        // Assert
        XCTAssert(viewController.viewModelProvider === presenter)
        XCTAssert(viewController.viewModel === presenter.viewModel)
    }

    func testCharactersViewControllerCoderInit() throws {
        // Assert
        XCTAssertNil(CharactersViewController(coder: NSCoder()))
    }
}
