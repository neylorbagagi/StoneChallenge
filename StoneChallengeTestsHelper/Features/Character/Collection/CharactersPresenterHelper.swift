//
//  CharactersPresenterHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension CharactersPresenter {
    public static func mock(
        interactor: CharactersInteractor = .mock(),
        router: CharactersRouter = .mock(),
        characterList: [Character] = []
    ) -> CharactersPresenter {
        .init(
            interactor: interactor,
            router: router,
            characterList: characterList
        )
    }
}
