//
//  CharactersViewControllerTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import XCTest
@testable import StoneChallenge

class CharactersViewControllerTests: XCTestCase {

    func test_characters_viewController_coder_init() throws {
        XCTAssertNil(CharactersViewController(coder: NSCoder()))
    }
}
