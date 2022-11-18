//
//  CharacterPresenter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class CharacterPresenter: CharacterViewModelProvider {

    let disposeBag = DisposeBag()

    // MARK: - VIEW MODELS
    lazy var viewModel: CharacterViewModel = {
        var viewModel = CharacterViewModel(
            title: character.name,
            backgroundColor: .white,
            description: description(character),
            image: UIImage()
        )
        return viewModel
    }()

    private var pagination = DataInfo<Character>.Info()

    let interactor: CharacterInteractor
    let router: CharacterRouter
    var character: Character

    init(interactor: CharacterInteractor,
         router: CharacterRouter,
         character: Character) {

        self.interactor = interactor
        self.router = router
        self.character = character

        bind()
    }

    // MARK: - PRIVATE FUNCTIONS
    private func description(_ character: Character) -> String {
        return """
            object {9}
                id : \(character.id)
                name : \(character.name)
                status : \(character.status)
                species : \(character.species)
                type : \(character.type != "" ? character.type : "unknown")
                gender : \(character.gender)
                origin {1}
                    name : \(character.origin.name)
                location {1}
                    name : \(character.location.name)
                episodes [\(character.episode.count)]
            """
    }

    // MARK: - BIND
    private func bind() {
        interactor.responseImageData
            .bind(to: viewModel.image)
            .disposed(by: disposeBag)

        viewModel.viewDidLoad
            .map { [self] in character.image }
            .bind(to: interactor.requestImageData)
            .disposed(by: disposeBag)
    }
}
