//
//  CharacterViewControllerFactoryTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
@testable import StoneChallenge

class CharacterViewControllerFactoryTests: XCTestCase {

    func test_character_viewController_factory() throws {

        let factory: UserDependencyContainer = .init()
        let character: Character = .mock()

        let controller = factory.characterViewControllerFactory(
            character: character
        )

        guard let viewController = controller as? CharacterViewController else {
            XCTFail("controller couldn't be cast to CharactersViewController")
            return
        }

        guard let presenter = viewController.viewModelProvider as? CharacterPresenter else {
            XCTFail("viewModelProvider couldn't be cast to CharactersPresenter")
            return
        }
        XCTAssertEqual(presenter.character, character)

        let router = presenter.router
        XCTAssertEqual(router.navigationController, factory.navigationController)

        let interactor = presenter.interactor
        XCTAssert(interactor.cache is ImageCacheProtocol)
    }
}
