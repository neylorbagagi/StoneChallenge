//
//  CharacterViewModelTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
import RxSwift

@testable import StoneChallenge

class CharacterViewModelTests: XCTestCase {

    func test_character_viewModel_init() throws {
        let title: String = .init()
        let backgroundColor: UIColor = .green
        let description: String = .init()
        let image: UIImage = .init()

        let viewModel = CharacterViewModel(
            title: title,
            backgroundColor: backgroundColor,
            description: description,
            image: image
        )

        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.backgroundColor, backgroundColor)
        XCTAssertEqual(viewModel.description, description)
        XCTAssertEqual(viewModel.image.value, image)
    }
}
