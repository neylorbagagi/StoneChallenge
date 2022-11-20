//
//  CharactersViewModel.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import RxRelay
import UIKit

protocol CharactersViewModelProvider {
    var viewModel: CharactersViewModel { get }
}

class CharactersViewModel {

    // MARK: - PUBLIC PROPERTIES
    var cellViewModels: BehaviorRelay<[CharacterCollectionViewModel]>
    let navigationLogoImage: UIImage
    let backgroundColor: UIColor

    // MARK: - EVENTS
    let viewDidLoad = PublishRelay<Void>()
    let collectionViewDidHitBottom = PublishRelay<Void>()
    let collectionViewDidSelectItem = PublishRelay<Int>()
    let rightBarButtonItemTap = PublishRelay<Void>()

    // TODO: TEST RIDUCILO mudar esse nome
    let requestImage = PublishRelay<Int>()

    // MARK: - COSNTRUCTORS
    init(cellViewModels: [CharacterCollectionViewModel],
         navigationLogoImage: UIImage,
         backgroundColor: UIColor) {
        self.cellViewModels = BehaviorRelay<[CharacterCollectionViewModel]>.init(value: cellViewModels)
        self.navigationLogoImage = navigationLogoImage
        self.backgroundColor = backgroundColor
    }
}
