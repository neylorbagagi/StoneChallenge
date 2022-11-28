//
//  charactersViewControllerFactoryTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
@testable import StoneChallenge

class CharactersViewControllerFactoryTests: XCTestCase {

    func test_characters_viewController_factory() throws {

        let factory: UserDependencyContainer = .init()

        let controller = factory.charactersViewControllerFactory(
            characterList: .init()
        )

        guard let viewController = controller as? CharactersViewController else {
            XCTFail("controller couldn't be cast to CharactersViewController")
            return
        }

        guard let presenter = viewController.viewModelProvider as? CharactersPresenter else {
            XCTFail("viewModelProvider couldn't be cast to CharactersPresenter")
            return
        }

        let router = presenter.router
        XCTAssertEqual(router.navigationController, factory.navigationController)

        let interactor = presenter.interactor
        XCTAssertNotNil(interactor.webService as? CharactersWebService)
        XCTAssertNotNil(interactor.cache as? ImageCache)
    }
}
