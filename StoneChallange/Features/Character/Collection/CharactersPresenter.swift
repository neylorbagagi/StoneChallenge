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
//    public let filterTrigger = PublishRelay<Void>()
    public let filterParams = PublishRelay<[APIParameters]>()

    // MARK: - VIEW MODELS
    lazy var viewModel: CharactersViewModel = {
        var viewModel = CharactersViewModel(
            cellViewModels: cellViewModels(characterList),
            navigationLogoImage: navigationLogoImage(),
            backgroundColor: .white
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
        characterList.map { CharacterCollectionViewModel(name: $0.name, image: UIImage()) }
    }

    private func updateViewModel(_ characters: [Character]) {

        characterList.append(contentsOf: characters)
        let viewModelList = cellViewModels(characters)

        viewModel.cellViewModels.accept(viewModel.cellViewModels.value + viewModelList)
    }

    func updateCharacterCollectionViewModel(row: Int, with: UIImage) {
        let test = viewModel.cellViewModels.value[row]
        test.image.accept(with)
    }

    func navigationLogoImage() -> UIImage {
        UIImage(named: "logo") ?? UIImage()
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

        viewModel.collectionViewDidSelectItem
            .map { [self] in characterList[$0] }
            .bind(to: router.showDetail)
            .disposed(by: disposeBag)

        viewModel.requestImage
            .map { [self] in ($0, characterList[$0].image) }
            .bind(to: interactor.getImage)
            .disposed(by: disposeBag)

        interactor.responseImage // TODO: isso tá feio
            .subscribe { [self] index, image in
                updateCharacterCollectionViewModel(row: index, with: image)
            }.disposed(by: disposeBag)

        viewModel.rightBarButtonItemTap
            .bind(to: router.showFilter)
            .disposed(by: disposeBag)

        filterParams
            .bind(to: interactor.requestFilterData)
            .disposed(by: disposeBag)
    }
}
