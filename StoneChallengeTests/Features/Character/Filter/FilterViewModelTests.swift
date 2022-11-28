//
//  FilterViewModelTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import XCTest
import RxSwift

@testable import StoneChallenge

class FilterViewModelTests: XCTestCase {

    func test_filter_viewModel_tests() throws {

        let title: String = .init()
        let backgroundColor: UIColor = .orange
        let textFieldPromptText: String = .init()
        let placeholderText: String = .init()
        let textFieldText: String? = .init()
        let segmentedControlPrompt: String = .init()
        let segmentOptionListText: [String] = .init()
        let segmentSelectedIndex: Int = Int()
        let applyFilterButtonTitle: String = .init()
        let resetFilterButtonTitle: String = .init()
        let errorText: String? = .init()

        let viewModel = FilterViewModel(
            title: title,
            backgroundColor: backgroundColor,
            textFieldPromptText: textFieldPromptText,
            placeholderText: placeholderText,
            textFieldText: textFieldText,
            segmentedControlPrompt: segmentedControlPrompt,
            segmentOptionListText: segmentOptionListText,
            segmentSelectedIndex: segmentSelectedIndex,
            applyFilterButtonTitle: applyFilterButtonTitle,
            resetFilterButtonTitle: resetFilterButtonTitle,
            errorText: errorText
        )

        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.backgroundColor, backgroundColor)
        XCTAssertEqual(viewModel.textFieldPromptText, textFieldPromptText)
        XCTAssertEqual(viewModel.placeholderText, placeholderText)
        XCTAssertEqual(viewModel.textFieldText, textFieldText)
        XCTAssertEqual(viewModel.segmentedControlPrompt, segmentedControlPrompt)
        XCTAssertEqual(viewModel.segmentOptionListText, segmentOptionListText)
        XCTAssertEqual(viewModel.segmentSelectedIndex, segmentSelectedIndex)
        XCTAssertEqual(viewModel.applyFilterButtonTitle, applyFilterButtonTitle)
        XCTAssertEqual(viewModel.resetFilterButtonTitle, resetFilterButtonTitle)
        XCTAssertEqual(viewModel.errorText.value, errorText)
    }
}
