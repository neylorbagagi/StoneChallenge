//
//  CharactersViewModel.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit

protocol CharactersViewModelProvider {
    var viewModel: CharactersViewModel { get }
}

class CharactersViewModel {

    var cellViewModels: [CharacterCollectionViewModel]

    internal init(cellViewModels: [CharacterCollectionViewModel]) {
        self.cellViewModels = cellViewModels
    }
}
