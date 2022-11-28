//
//  CharacterRouterTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
import RxSwift
import RxTest

@testable import StoneChallenge

class CharacterRouterTests: XCTestCase {

    var disposeBag = DisposeBag()

    func test_character_router() throws {

        // Arrange
        let userDependencyContainer: UserDependencyContainer = .init()

        // Act
        let router = CharacterRouter(
            viewControllerFactory: userDependencyContainer
        )

        // Assert
        XCTAssert(router.viewControllerFactory === userDependencyContainer)
        XCTAssert(router.navigationController === userDependencyContainer.navigationController)
    }
}
