//
//  CharacterViewModel.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

protocol CharacterViewModelProvider {
    var viewModel: CharacterViewModel { get }
}

class CharacterViewModel {

    let title: String
    let backgroundColor: UIColor
    let description: String
    let image: BehaviorRelay<UIImage>

    // MARK: - EVENTS
    let viewDidLoad = PublishRelay<Void>()

    // MARK: - COSNTRUCTORS
    init(title: String, backgroundColor: UIColor, description: String, image: UIImage) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.description = description
        self.image = BehaviorRelay<UIImage>.init(value: image)
    }
}
