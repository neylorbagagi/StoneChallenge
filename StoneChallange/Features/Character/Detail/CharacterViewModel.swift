//
//  CharacterViewModel.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import Foundation
import UIKit

protocol CharacterViewModelProvider {
    var viewModel: CharacterViewModel { get }
}

class CharacterViewModel {
    let description: String
    let image: UIImage // TODO: make it a observable

    // MARK: - COSNTRUCTORS
    init(description: String, image: UIImage) {
        self.description = description
        self.image = image
    }
}
