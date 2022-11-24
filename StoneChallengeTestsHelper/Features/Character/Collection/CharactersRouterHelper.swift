//
//  CharactersRouterHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension CharactersRouter {
    public static func mock(
        userDependencyContainer: UserDependencyContainer = .init()
    ) -> CharactersRouter {
        .init(viewControllerFactory: userDependencyContainer)
    }
}
