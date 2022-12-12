//
//  StatusTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 01/12/22.
//

import XCTest
@testable import StoneChallenge

class StatusTests: XCTestCase {

    func testGetPosition() throws {

        for param in APIParameter.Status.allCases {
            switch param {
            case .alive:
                XCTAssertEqual(param.getPosition(), 0)
            case .dead:
                XCTAssertEqual(param.getPosition(), 1)
            case .unknown:
                XCTAssertEqual(param.getPosition(), 2)
            }
        }
    }
}
