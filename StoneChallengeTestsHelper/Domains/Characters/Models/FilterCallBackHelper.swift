//
//  FilterCallBackHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension FilterCallBack {

    public static func mock(
        data: DataInfo<Character> = .mock(), // TODO: change it to T
        parameters: [APIParameters]? = .init()
    ) -> FilterCallBack {
        .init(data: data, parameters: parameters)
    }
}
