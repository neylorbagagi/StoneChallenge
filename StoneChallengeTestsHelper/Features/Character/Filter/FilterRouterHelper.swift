//
//  FilterRouterHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 28/11/22.
//

import Foundation
@testable import StoneChallenge

extension FilterRouter {
    public static func mock(
        userDependencyContainer: UserDependencyContainer = .init()
    ) -> FilterRouter {
        .init(viewControllerFactory: userDependencyContainer)
    }
}
