//
//  CharactersViewModel.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import RxRelay

protocol CharactersViewModelProvider {
    var viewModel: CharactersViewModel { get }
}

class CharactersViewModel {

    // MARK: - PUBLIC PROPERTIES
    var cellViewModels: BehaviorRelay<[CharacterCollectionViewModel]>

    // MARK: - EVENTS
    let viewDidLoad = PublishRelay<Void>()
    let collectionViewDidHitBottom = PublishRelay<Void>()
    let collectionViewDidSelectItem = PublishRelay<Int>()

    // MARK: - COSNTRUCTORS
    init(cellViewModels: [CharacterCollectionViewModel]) {
        self.cellViewModels = BehaviorRelay<[CharacterCollectionViewModel]>.init(value: cellViewModels)
    }
}
