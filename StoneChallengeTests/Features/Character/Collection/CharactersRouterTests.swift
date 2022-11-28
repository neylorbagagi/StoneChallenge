//
//  CharactersRouterTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
import RxSwift
import RxTest

@testable import StoneChallenge

class CharactersRouterTests: XCTestCase {

    var disposeBag = DisposeBag()

    func test_characters_router() throws {

        // Arrange
        let userDependencyContainer: UserDependencyContainer = .init()

        // Act
        let router = CharactersRouter(
            viewControllerFactory: userDependencyContainer
        )

        // Assert
        XCTAssert(router.viewControllerFactory === userDependencyContainer)
        XCTAssert(router.navigationController === userDependencyContainer.navigationController)
    }

    func test_characters_showDetail() throws {

        // Arrange
        let router = CharactersRouter(
            viewControllerFactory: .init()
        )

        // Act
        router.showDetail.accept(.mock())

        // Assert
        XCTAssert(router.navigationController.topViewController is CharacterViewController)
    }

    func test_characters_showFilter() throws {

        // Arrange
        let router = CharactersRouter(
            viewControllerFactory: .init()
        )

        // Act
        router.showFilter.accept((PublishSubject<FilterCallBack>.init(), []))

        // Assert
        XCTAssert(router.navigationController.topViewController is FilterViewController)
    }
}
