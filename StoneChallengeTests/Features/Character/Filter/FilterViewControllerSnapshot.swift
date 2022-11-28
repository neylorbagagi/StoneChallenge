//
//  FilterViewControllerSnapshot.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 28/11/22.
//

import SnapshotTesting
import XCTest

@testable import StoneChallenge

class FilterViewControllerSnapshot: XCTestCase {

    func test_filter_viewController_snapshot() throws {

        isRecording = false

        let sut = FilterViewController(
            viewModelProvider: FilterPresenter(
                interactor: FilterInteractor.mock(),
                router: FilterRouter.mock(),
                filterCallBack: .init(),
                filterParameters: []
            )
        )

        assertSnapshots(matching: sut, as: [.image])
    }
}
