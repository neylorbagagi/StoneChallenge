//
//  InfoHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension DataInfo.Info: Equatable {

    public static func mock(
        count: Int = .init(),
        pages: Int = .init(),
        next: String? = nil,
        prev: String? = nil
    ) -> DataInfo.Info {
        .init(count: count, pages: pages, next: next, prev: prev)
    }

    public static func == (lhs: DataInfo.Info, rhs: DataInfo.Info) -> Bool {
        lhs.count == rhs.count &&
        lhs.pages == rhs.pages &&
        lhs.next == rhs.next &&
        lhs.prev == rhs.prev
    }
}
