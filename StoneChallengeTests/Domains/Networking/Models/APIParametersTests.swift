//
//  APIParametersTests.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 01/12/22.
//

import XCTest
@testable import StoneChallenge

class APIParametersTests: XCTestCase {

    func testDescribe() throws {

        for param in APIParameter.allCases {
            switch param {
            case .name:
                XCTAssertEqual(param.describe(), "name")
            case .status:
                XCTAssertEqual(param.describe(), "status")
            case .species:
                XCTAssertEqual(param.describe(), "species")
            case .type:
                XCTAssertEqual(param.describe(), "type")
            case .gender:
                XCTAssertEqual(param.describe(), "gender")
            }
        }
    }

    func testGetValue() throws {

        let string = ["name", "status", "species", "type", "gender"]

        let params = [
            APIParameter.name(string[0]),
            APIParameter.status(APIParameter.Status(rawValue: string[1])),
            APIParameter.species(string[2]),
            APIParameter.type(string[3]),
            APIParameter.gender(APIParameter.Gender(rawValue: string[4]))
        ]

        for param in params {
            switch param {
            case .name:
                XCTAssertEqual(param.getValue(), string[0])
            case .status:
                XCTAssertEqual(param.describe(), string[1])
            case .species:
                XCTAssertEqual(param.getValue(), string[2])
            case .type:
                XCTAssertEqual(param.getValue(), string[3])
            case .gender:
                XCTAssertEqual(param.describe(), string[4])
            }
        }
    }

    func testWithLabel() throws {

        let string = "name"
        let param: APIParameter = .name(string)
        let params: [APIParameter] = [param]

        XCTAssertEqual(params.first, param)
    }
}
