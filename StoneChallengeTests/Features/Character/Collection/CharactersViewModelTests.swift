//
//  CharactersViewModelTests.swift
//  StoneChallangeTests
//
//  Created by Neylor Bagagi on 20/11/22.
//

import XCTest
import RxRelay
@testable import StoneChallenge

class CharactersViewModelTests: XCTestCase {

    func testCharactersViewModelInitialization() throws {

        let cellViewModels: BehaviorRelay<[CharacterCollectionViewModel]> = .init(value: [])
        let navigationLogoImage: UIImage = .init()
        let backgroundColor: UIColor = .green
        let rightBarButtonItemTitle: String = .init()

        let viewModel = CharactersViewModel(
            cellViewModels: cellViewModels.value,
            navigationLogoImage: navigationLogoImage,
            backgroundColor: backgroundColor,
            rightBarButtonItemTitle: rightBarButtonItemTitle
        )

//        XCTAssertEqual(viewModel.cellViewModels.value, cellViewModels.value)
        XCTAssertEqual(viewModel.navigationLogoImage, navigationLogoImage)
        XCTAssertEqual(viewModel.backgroundColor, backgroundColor)
        XCTAssertEqual(viewModel.rightBarButtonItemTitle, rightBarButtonItemTitle)
    }

}
