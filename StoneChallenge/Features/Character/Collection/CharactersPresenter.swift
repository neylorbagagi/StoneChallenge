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

    // MARK: - SUBJECTS
    public let nextPageTrigger = PublishRelay<Void>()
    public let filterCallBack = PublishSubject<FilterCallBack>()

    // MARK: - VIEW MODELS
    lazy var viewModel: CharactersViewModel = {
        var viewModel = CharactersViewModel(
            cellViewModels: cellViewModels(characterList),
            navigationLogoImage: navigationLogoImage(),
            backgroundColor: .white,
            rightBarButtonItemTitle: NSLocalizedString(
                "characters_view_controller_rightBarButtonItem_title",
                comment: ""
            )
        )
        return viewModel
    }()

    // MARK: - PRIVATE PROPERTIES
    private var pagination = DataInfo<Character>.Info(next: "https://rickandmortyapi.com/api/character")
    private var filterParams: [APIParameters]?
    private let disposeBag = DisposeBag()

    // MARK: - INJECTED PROPERTIES
    let interactor: CharactersInteractor
    let router: CharactersRouter
    var characterList: [Character]

    // MARK: - CONSTRUCTORS
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

    private func updateWithDataFromNextPage(_ characters: [Character]) {
        characterList.append(contentsOf: characters)
        let viewModelList = cellViewModels(characters)
        viewModel.cellViewModels.accept(viewModel.cellViewModels.value + viewModelList)
    }

    private func updateWithDataFromFilter(_ characters: [Character]) {
        characterList = characters
        let viewModelList = cellViewModels(characters)
        viewModel.cellViewModels.accept(viewModelList)
    }

    private func updateCharacterCollectionViewModel(row: Int, with image: UIImage) {
        let cellViewModel = viewModel.cellViewModels.value[row]
        cellViewModel.image.accept(image)
    }

    private func navigationLogoImage() -> UIImage {
        UIImage(named: "logo") ?? UIImage()
    }

    // MARK: - BIND
    private func bind() {

        viewModel.viewDidLoad
            .bind(to: nextPageTrigger)
            .disposed(by: disposeBag)

        viewModel.collectionViewDidHitBottom
            .bind(to: nextPageTrigger)
            .disposed(by: disposeBag)

        viewModel.collectionViewDidSelectItem
            .map { [self] in characterList[$0] }
            .bind(to: router.showDetail)
            .disposed(by: disposeBag)

        viewModel.willConfigCell
            .map { [self] in ($0, characterList[$0].image) }
            .bind(to: interactor.requestImageData)
            .disposed(by: disposeBag)

        viewModel.rightBarButtonItemTap
            .map { [self] in (filterCallBack, filterParams) }
            .bind(to: router.showFilter)
            .disposed(by: disposeBag)

        nextPageTrigger
            .compactMap { [self] in pagination.next }
            .bind(to: interactor.requestPageData)
            .disposed(by: disposeBag)

        interactor.responseImageData
            .subscribe { [self] index, image in
                updateCharacterCollectionViewModel(row: index, with: image)
            }.disposed(by: disposeBag)

        interactor.responsePageData
            .subscribe(onNext: { [self] result in
                if case let .success(data) = result {
                    pagination = data.info
                    updateWithDataFromNextPage(data.results)
                }
            })
            .disposed(by: disposeBag)

        filterCallBack
            .subscribe(onNext: { [self] response in
                pagination = response.data.info
                filterParams = response.parameters
                updateWithDataFromFilter(response.data.results)
            }).disposed(by: disposeBag)
    }
}
