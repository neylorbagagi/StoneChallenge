//
//  CharactersViewModelTests.swift
//  StoneChallangeTests
//
//  Created by Neylor Bagagi on 20/11/22.
//

import XCTest
@testable import StoneChallange
import RxRelay

class CharactersViewModelTests: XCTestCase {

    func testCharactersViewModelInitialization() throws {

        let cellViewModels: BehaviorRelay<[CharacterCollectionViewModel]> = .init(value: [])
        let navigationLogoImage: UIImage = .init()
        let backgroundColor: UIColor = .init()

        let viewModel = CharactersViewModel(
            cellViewModels: cellViewModels.value,
            navigationLogoImage: navigationLogoImage,
            backgroundColor: backgroundColor
        )

//        XCTAssertEqual(viewModel.cellViewModels.value, cellViewModels.value)
        XCTAssertEqual(viewModel.navigationLogoImage, navigationLogoImage)
        XCTAssertEqual(viewModel.backgroundColor, backgroundColor)
    }

}
