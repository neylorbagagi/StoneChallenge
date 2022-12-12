//
//  CharacterViewControllerTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
@testable import StoneChallenge

class CharacterViewControllerTests: XCTestCase {

    func testCharacterViewControllerInit() throws {

        let presenter: CharacterPresenter = .mock()

        let viewController = CharacterViewController(
            viewModelProvider: presenter
        )

        XCTAssert(viewController.viewModelProvider === presenter)
        XCTAssert(viewController.viewModel === presenter.viewModel)
    }

    func test_character_viewController_coder_init() throws {
        XCTAssertNil(CharacterViewController(coder: NSCoder()))
    }
}
