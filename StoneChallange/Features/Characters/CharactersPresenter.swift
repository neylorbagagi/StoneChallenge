//
//  CharactersPresenter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class CharactersPresenter: CharactersViewModelProvider {

    let disposeBag = DisposeBag()

    public let nextPageTrigger = PublishRelay<Void>()

    // MARK: - VIEW MODELS
    lazy var viewModel: CharactersViewModel = {
        var viewModel = CharactersViewModel(
            cellViewModels: cellViewModels(characterList)
        )
        return viewModel
    }()

    private var pagination = DataInfo<Character>.Info()

    let interactor: CharactersInteractor
    let router: CharactersRouter
    var characterList: [Character] // TODO: Should it to be a var ?

    init(interactor: CharactersInteractor,
         router: CharactersRouter,
         characterList: [Character]) {

        self.interactor = interactor
        self.router = router
        self.characterList = characterList

        bind()
    }

    // MARK: - PRIVATE FUNCTIONS
    private func cellViewModels(_ characterList: [Character]) -> [CharacterCollectionViewModel] {
        return characterList.map { CharacterCollectionViewModel(name: $0.name, image: UIImage()) }
    }

    // TODO: Change names for this intire func
    private func updateViewModel(_ characters: [Character]) {
        #warning ("Do I have to Create again all cellViewModels?")
        // appending characterList with the new characters
        characterList.append(contentsOf: characters)

        // creating new viewModels for then
        let viewModelList = cellViewModels(characters)

        // adding them to cellViewModels
        viewModel.cellViewModels.accept(viewModel.cellViewModels.value + viewModelList)
    }

    // MARK: - BIND
    private func bind() {

        // TODO: Do I really need this guy?
        interactor.responsePageData
            .subscribe(onNext: { [self] dataInfo in
                pagination = dataInfo.info
                updateViewModel(dataInfo.results)
            }, onError: { error in
                // TODO: present some error dialog
                print(error)
            }).disposed(by: disposeBag)

        viewModel.viewDidLoad
            .bind(to: nextPageTrigger)
            .disposed(by: disposeBag)

        viewModel.collectionViewDidHitBottom
            .bind(to: nextPageTrigger)
            .disposed(by: disposeBag)

        nextPageTrigger
            .compactMap { [self] in pagination.next }
            .bind(to: interactor.requestPageData)
            .disposed(by: disposeBag)
    }
}
