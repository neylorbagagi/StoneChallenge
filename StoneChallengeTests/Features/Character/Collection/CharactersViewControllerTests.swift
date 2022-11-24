//
//  CharactersViewControllerTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import XCTest
@testable import StoneChallenge

class CharactersViewControllerTests: XCTestCase {

    // TODO: Fix this one
//    func test_characters_viewController_init() throws {
//
//        let viewModelProvider = CharactersPresenter(
//            interactor: CharactersInteractor(
//                webService: CharactersWebService(),
//                cache: ImageCache()
//            ),
//            router: CharactersRouter(
//                viewControllerFactory: UserDependencyContainer()
//            ),
//            characterList: []
//        )
//
//        let viewController = CharactersViewController(
//            viewModelProvider: viewModelProvider
//        )
//
//        XCTAssert(viewController.viewModelProvider.self === CharactersViewModelProvider)
//    }

    func test_characters_viewController_coder_init() throws {
        XCTAssertNil(CharactersViewController(coder: NSCoder()))
    }
}
