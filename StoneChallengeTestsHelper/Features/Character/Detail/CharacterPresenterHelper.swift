//
//  CharacterPresenterHelper.swift
//  StoneChallenge
//
//  Created by Neylor Bagagi on 25/11/22.
//

import Foundation
@testable import StoneChallenge

extension CharacterPresenter {
    public static func mock(
        interactor: CharacterInteractor = .mock(),
        router: CharacterRouter = .mock(),
        character: Character = .mock()
    ) -> CharacterPresenter {
        .init(
            interactor: interactor,
            router: router,
            character: character
        )
    }
}
