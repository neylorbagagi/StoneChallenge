//
//  CharacterCollectionViewModelHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension CharacterCollectionViewModel: Equatable {
    public static func == (lhs: CharacterCollectionViewModel, rhs: CharacterCollectionViewModel) -> Bool {
        lhs.name == rhs.name &&
        lhs.image.value == rhs.image.value
    }
}
