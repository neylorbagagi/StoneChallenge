//
//  CharacterWebServiceTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 01/12/22.
//

import XCTest
@testable import StoneChallenge

class CharacterWebServiceTests: XCTestCase {

    func testGetCharacter() throws {

        let id: Int = .init()
        let webService = CharacterWebServiceStub()

        XCTContext.runActivity(named: "success") { _ -> Void in
            webService.getCharacter(byID: id) { result in
                switch result {
                case .success:
                    XCTAssertTrue(true)
                case .failure:
                    XCTFail("XCTFail")
                }
            }
        }

        XCTContext.runActivity(named: "failure") { _ -> Void in

            webService.response = .failure(NSError.init())
            webService.getCharacter(byID: id) { result in
                switch result {
                case .success:
                    XCTFail("XCTFail")
                case .failure:
                    XCTAssertTrue(true)
                }
            }
        }
    }
}
