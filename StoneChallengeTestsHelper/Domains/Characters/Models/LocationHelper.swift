//
//  LocationHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension Character.Location: Equatable {

    public static func mock(
        name: String = .init(),
        url: String = .init()
    ) -> Character.Location {
        .init(name: name, url: url)
    }

    public static func == (lhs: Character.Location, rhs: Character.Location) -> Bool {
        lhs.name == rhs.name &&
        lhs.url == rhs.url
    }
}
