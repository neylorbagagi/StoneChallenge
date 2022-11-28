//
//  CharacterViewControllerTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
@testable import StoneChallenge

class CharacterViewControllerTests: XCTestCase {

    func test_character_viewController() throws {
        #warning("test_character_viewController")
    }

    func test_character_viewController_coder_init() throws {
        XCTAssertNil(CharacterViewController(coder: NSCoder()))
    }
}
