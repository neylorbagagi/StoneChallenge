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
        XCTAssert(interactor.webService === webService)
        XCTAssert(interactor.cache === cache)
    }

    func test_requestPageData() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)

        let webService: CharactersWebServiceStub = .init()
        let cache: ImageCache = .init()

        let interactor = CharactersInteractor(
            webService: webService,
            cache: cache
        )

        XCTContext.runActivity(named: "success with valid url") { _ -> Void in

            // Arrange
            let monitor = scheduler.createObserver(Result<DataInfo<Character>, Error>.self)
            webService.response = .success(DataInfo<Character>.mock())

            // Act
            interactor.responsePageData
                .bind(to: monitor)
                .disposed(by: disposeBag)

            interactor.requestPageData.accept(String())

            let monitorResponse = monitor.events.first?.value.element
            switch monitorResponse {
            case .failure:
                XCTFail("XCTFail")
            case .success:
                XCTAssertTrue(true)
            case .none:
                XCTFail("XCTFail")
            }

            //TODO: XCTAssertEqual(monitor.events.first?.value, webService.response)
        }

        XCTContext.runActivity(named: "failure with invalid url") { _ -> Void in

            // Arrange
            let monitor = scheduler.createObserver(Result<DataInfo<Character>, Error>.self)
            webService.response = .failure(NSError.init())

            // Act
            interactor.responsePageData
                .bind(to: monitor)
                .disposed(by: disposeBag)

            interactor.requestPageData.accept(String())

            let monitorResponse = monitor.events.first?.value.element
            switch monitorResponse {
            case .failure:
                XCTAssertTrue(true)
            case .success:
                XCTFail("XCTFail")
            case .none:
                XCTFail("XCTFail")
            }
        }
    }
}
