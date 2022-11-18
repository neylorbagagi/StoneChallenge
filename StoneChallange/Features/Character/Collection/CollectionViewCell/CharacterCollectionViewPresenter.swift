//
//  CharacterCollectionViewPresenter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit

class CharacterCollectionViewPresenter: CharacterCollectionViewModelProvider {

    lazy var viewModel: CharacterCollectionViewModel = .init(
        name: character.name,
        image: UIImage()
    )

    private let character: Character

    init(character: Character) {
        self.character = character
    }
}
