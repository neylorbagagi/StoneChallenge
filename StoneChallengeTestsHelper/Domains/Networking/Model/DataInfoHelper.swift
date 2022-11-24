//
//  DataInfoHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension DataInfo {

    public static func mock(
        info: Info = .mock(),
        results: [T] = .init()
    ) -> DataInfo {
        .init(info: info, results: results)
    }
}
