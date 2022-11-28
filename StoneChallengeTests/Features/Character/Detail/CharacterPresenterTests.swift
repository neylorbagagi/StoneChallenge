//
//  CharacterPresenterTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
import RxSwift
import RxTest

@testable import StoneChallenge

class CharacterPresenterTests: XCTestCase {

    var disposeBag = DisposeBag()

    func test_character_presenter() throws {

        // Arrange
        let interactor: CharacterInteractor = .mock()
        let router: CharacterRouter = .mock()
        let character: Character = .mock()

        // Act
        let presenter = CharacterPresenter(
            interactor: interactor,
            router: router,
            character: character
        )

        // Assert
        XCTAssert(presenter.interactor === interactor)
        XCTAssert(presenter.router === router)
        XCTAssertEqual(presenter.character, character)
    }

    func test_character_viewModel_viewDidLoad() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let monitor = scheduler.createObserver(String.self)

        let interactor: CharacterInteractor = .mock()
        let presenter = CharacterPresenter.mock(
            interactor: interactor
        )

        // Act
        interactor.requestImageData
            .map { _ in String() }
            .bind(to: monitor)
            .disposed(by: disposeBag)

        presenter.viewModel.viewDidLoad.accept(())

        // Assert
        XCTAssertEqual(monitor.events.count, 1)
    }
}
