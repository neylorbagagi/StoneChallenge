//
//  CharacterInteractorTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
import RxSwift
import RxTest
import RxRelay

@testable import StoneChallenge

class CharacterInteractorTests: XCTestCase {

    var disposeBag = DisposeBag()

    func test_character_interactor() throws {

        // Arrange
        let cache: ImageCacheStub = .init()

        // Act
        let interactor = CharacterInteractor(
            cache: cache
        )

        // Assert
        XCTAssert(interactor.cache is ImageCacheProtocol)
    }

    func test_requestImageData() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let cache = ImageCacheStub()

        let interactor = CharacterInteractor(
            cache: cache
        )

        XCTContext.runActivity(named: "success with valid image url") { _ -> Void in

            cache.response = UIImage()

            let monitor = scheduler.createObserver(UIImage.self)
            interactor.responseImageData
                .bind(to: monitor)
                .disposed(by: disposeBag)

            // Act
            interactor.requestImageData.accept(String())

            // Assert
            XCTAssertNotNil(monitor.events.first?.value.element)
        }

        XCTContext.runActivity(named: "failure with invalid image url") { _ -> Void in

            cache.response = nil

            let monitor = scheduler.createObserver(UIImage.self)
            interactor.responseImageData
                .bind(to: monitor)
                .disposed(by: disposeBag)

            // Act
            interactor.requestImageData.accept(String())

            // Assert
            XCTAssertEqual(monitor.events.first?.value.element, cache.placeholderImage)
        }
    }
}
