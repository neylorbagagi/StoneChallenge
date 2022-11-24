//
//  CharactersInteractorTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import XCTest
import RxSwift
import RxTest
import RxRelay
@testable import StoneChallenge

class CharactersInteractorTests: XCTestCase {

    var disposeBag = DisposeBag()

    func test_characters_interactor() throws {

        // Arrange
        let webService: CharactersWebService = .init()
        let cache: ImageCache = .init()

        // Act
        let interactor = CharactersInteractor(
            webService: webService,
            cache: cache
        )

        // Assert
        XCTAssert(interactor.webService === CharactersWebService.self)
        XCTAssert(interactor.cache === ImageCache.self)
    }

    func test_requestPageData() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)

        let webService: CharactersWebService = .init()
        let cache: ImageCache = .init()

        let interactor = CharactersInteractor(
            webService: webService,
            cache: cache
        )

        XCTContext.runActivity(named: "success with valid url") { _ -> Void in

            // Arrange
            let monitor = scheduler.createObserver(Result<DataInfo<Character>, Error>.self)

            scheduler.createColdObservable([
                .init(
                    time: 0,
                    value: .next(
                        PublishRelay<Result<DataInfo<Character>, Error>>.just(.success(DataInfo.mock()))
                    )
                )
            ])

            // Act
            interactor.responsePageData
                .bind(to: monitor)
                .disposed(by: disposeBag)

            interactor.requestPageData.accept(String())

            scheduler.start()
            // Assert
            XCTAssertEqual(monitor.events.count, 1)
        }

        XCTContext.runActivity(named: "failure with valid url") { _ -> Void in

            // Arrange
            let monitor = scheduler.createObserver(Result<DataInfo<Character>, Error>.self)

            // Act
            interactor.responsePageData
                .bind(to: monitor)
                .disposed(by: disposeBag)

            interactor.requestPageData.accept("google.com")

            // Assert
            XCTAssertEqual(monitor.events.count, 0)
        }
    }
}
