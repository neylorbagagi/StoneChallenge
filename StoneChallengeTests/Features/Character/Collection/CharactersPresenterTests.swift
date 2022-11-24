//
//  CharactersPresenterTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import XCTest
import RxSwift
import RxTest

@testable import StoneChallenge

class CharactersPresenterTests: XCTestCase {

    var disposeBag = DisposeBag()

    func test_characters_presenter() throws {

        let interactor: CharactersInteractor = .mock()
        let router: CharactersRouter = .mock()
        let characterList: [Character] = []

        let presenter = CharactersPresenter(
            interactor: interactor,
            router: router,
            characterList: characterList
        )

        XCTAssert(presenter.interactor === interactor)
        XCTAssert(presenter.router === router)
        XCTAssertEqual(presenter.characterList, characterList)
    }

    func test_characters_viewModel_viewDidLoad() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let monitor = scheduler.createObserver(Void.self)

        let presenter = CharactersPresenter.mock()

        // Act
        presenter.nextPageTrigger
            .bind(to: monitor)
            .disposed(by: disposeBag)

        presenter.viewModel.viewDidLoad.accept(())

        // Assert
        XCTAssertEqual(monitor.events.count, 1)
    }

    func test_characters_viewModel_collectionViewDidHitBottom() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let monitor = scheduler.createObserver(Void.self)

        let presenter = CharactersPresenter.mock()

        // Act
        presenter.nextPageTrigger
            .bind(to: monitor)
            .disposed(by: disposeBag)

        presenter.viewModel.collectionViewDidHitBottom.accept(())

        // Assert
        XCTAssertEqual(monitor.events.count, 1)
    }

    func test_characters_viewModel_collectionViewDidSelectItem() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let monitor = scheduler.createObserver(Character.self)

        let characterList = [Character.mock(), Character.mock(), Character.mock()]
        let position = 1
        let character = characterList[position]

        let router = CharactersRouter.mock()
        let presenter = CharactersPresenter.mock(
            router: router,
            characterList: characterList
        )

        // Act
        router.showDetail
            .map { _ in presenter.characterList[position] }
            .bind(to: monitor)
            .disposed(by: disposeBag)

        presenter.viewModel.collectionViewDidSelectItem.accept(position)

        // Assert
        XCTAssertEqual(monitor.events.count, 1)
        XCTAssertEqual(monitor.events.first, .next(0, character))
    }

    func test_characters_viewModel_willConfigCell() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let monitor = scheduler.createObserver((position:Int, image:String).self)

        let interactor = CharactersInteractor.mock()
        let position = 0

        let imageString = "wuba.png"
        let characterList = [Character.mock(image: imageString)]

        let presenter = CharactersPresenter.mock(
            interactor: interactor,
            characterList: characterList
        )

        // Act
        interactor.requestImageData
            .map { _ in (position, presenter.characterList[position].image) }
            .bind(to: monitor)
            .disposed(by: disposeBag)

        presenter.viewModel.willConfigCell.accept(position)

        // Assert
        XCTAssertEqual(monitor.events.count, 1)
        XCTAssertEqual(monitor.events.first?.value.element?.position, position)
        XCTAssertEqual(monitor.events.first?.value.element?.image, imageString)
    }

    func test_characters_viewModel_rightBarButtonItemTap() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let monitor = scheduler.createObserver(
            (callback: PublishSubject<FilterCallBack>, params: [APIParameters]?).self
        )

        let router = CharactersRouter.mock()
        let presenter = CharactersPresenter.mock(
            router: router
        )

        // Act
        router.showFilter
            .map { _ in
                (PublishSubject<FilterCallBack>(), [APIParameters.name(String())])
            }
            .bind(to: monitor)
            .disposed(by: disposeBag)

        presenter.viewModel.rightBarButtonItemTap.accept(())

        // Assert
        XCTAssertEqual(monitor.events.count, 1)
        XCTAssertNotNil(monitor.events.first)
    }

    func test_nextPageTrigger() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let monitor = scheduler.createObserver(String.self)

        let paginationNext = "google.com"

        let interactor = CharactersInteractor.mock()
        let presenter = CharactersPresenter.mock(
            interactor: interactor
        )

        // Act
        interactor.requestPageData
            .map { _ in paginationNext }
            .bind(to: monitor)
            .disposed(by: disposeBag)

        presenter.nextPageTrigger.accept(())

        // Assert
        XCTAssertEqual(monitor.events.count, 1)
        XCTAssertEqual(monitor.events.first, .next(0, paginationNext))
    }

    func test_interactor_responsePageData() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)

        let interactor = CharactersInteractor.mock()
        let presenter = CharactersPresenter.mock(
            interactor: interactor
        )

        XCTContext.runActivity(named: "success") { _ -> Void in

            // Arrange
            let monitor = scheduler.createObserver([CharacterCollectionViewModel].self)

            // Act
            presenter.viewModel.cellViewModels.skip(1)
                .bind(to: monitor)
                .disposed(by: disposeBag)

            interactor.responsePageData.accept(.success(DataInfo.mock()))

            // Assert
            XCTAssertEqual(monitor.events.count, 1)
        }

        XCTContext.runActivity(named: "failure") { _ -> Void in

            // Arrange
            let monitor = scheduler.createObserver([CharacterCollectionViewModel].self)

            // Act
            presenter.viewModel.cellViewModels.skip(1)
                .bind(to: monitor)
                .disposed(by: disposeBag)

            interactor.responsePageData.accept(.failure(NSError.init()))

            // Assert
            XCTAssertEqual(monitor.events.count, 0)
        }
    }

    func test_interactor_filterCallBack() throws {

        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let monitor = scheduler.createObserver([CharacterCollectionViewModel].self)

        let interactor = CharactersInteractor.mock()
        let presenter = CharactersPresenter.mock(
            interactor: interactor
        )

        // Act
        presenter.viewModel.cellViewModels.skip(1)
            .bind(to: monitor)
            .disposed(by: disposeBag)

        presenter.filterCallBack.onNext(FilterCallBack.mock())

        // Assert
        XCTAssertEqual(monitor.events.count, 1)
    }
}
