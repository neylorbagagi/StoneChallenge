//
//  CharacterCollectionViewModel.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import UIKit

protocol CharacterCollectionViewModelProvider {
    var viewModel: CharacterCollectionViewModel { get }
}

final class CharacterCollectionViewModel {

    let name: String
    let image: UIImage

    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
