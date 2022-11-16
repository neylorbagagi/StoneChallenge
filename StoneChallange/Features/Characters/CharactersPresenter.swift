//
//  CharactersPresenter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit

class CharactersPresenter: CharactersViewModelProvider {

    lazy var viewModel: CharactersViewModel = .init(
        cellViewModels: cellViewModels()
    )

    let interactor: CharactersInteractor
    let router: CharactersRouter

    let characterList: [Character]

    init(interactor: CharactersInteractor,
         router: CharactersRouter,
         characterList: [Character]) {

        self.interactor = interactor
        self.router = router
        self.characterList = characterList
    }

    func cellViewModels() -> [CharacterCollectionViewModel] {
        return [.init(name: "Gabriela", image: UIImage()),
                .init(name: "Gabriela", image: UIImage()),
                .init(name: "Gabriela", image: UIImage()),
                .init(name: "Gabriela", image: UIImage()),
                .init(name: "Gabriela", image: UIImage())]
    }
}
