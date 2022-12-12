//
//  CharactersViewModelTests.swift
//  StoneChallangeTests
//
//  Created by Neylor Bagagi on 20/11/22.
//

import XCTest
import RxSwift

@testable import StoneChallenge

class CharactersViewModelTests: XCTestCase {

    func testCharactersViewModelInit() throws {

        // Arrange
        let cellViewModels: [CharacterCollectionViewModel] = []
        let navigationLogoImage: UIImage = .init()
        let backgroundColor: UIColor = .green
        let rightBarButtonItemTitle: String = .init()

        // Act
        let viewModel = CharactersViewModel(
            cellViewModels: cellViewModels,
            navigationLogoImage: navigationLogoImage,
            backgroundColor: backgroundColor,
            rightBarButtonItemTitle: rightBarButtonItemTitle
        )

        // Assert
        XCTAssertEqual(viewModel.cellViewModels.value, cellViewModels)
        XCTAssertEqual(viewModel.navigationLogoImage, navigationLogoImage)
        XCTAssertEqual(viewModel.backgroundColor, backgroundColor)
        XCTAssertEqual(viewModel.rightBarButtonItemTitle, rightBarButtonItemTitle)
    }
}
