//
//  APIParametersHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 12/12/22.
//

import Foundation
@testable import StoneChallenge

extension APIParameter: Equatable {

    public static func == (lhs: APIParameter, rhs: APIParameter) -> Bool {
        lhs.describe() == rhs.describe() &&
        lhs.getValue() == rhs.getValue()
    }
}
