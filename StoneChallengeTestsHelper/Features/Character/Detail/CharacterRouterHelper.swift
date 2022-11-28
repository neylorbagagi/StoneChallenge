//
//  CharacterRouterHelper.swift
//  StoneChallenge
//
//  Created by Neylor Bagagi on 25/11/22.
//

import Foundation
@testable import StoneChallenge

extension CharacterRouter {
    public static func mock(
        userDependencyContainer: UserDependencyContainer = .init()
    ) -> CharacterRouter {
        .init(viewControllerFactory: userDependencyContainer)
    }
}
