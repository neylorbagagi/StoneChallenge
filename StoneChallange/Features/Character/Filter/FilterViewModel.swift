//
//  FilterViewModel.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation
import UIKit
import RxRelay

protocol FilterViewModelProvider {
    var viewModel: FilterViewModel { get }
}

class FilterViewModel {

    // MARK: - PUBLIC PROPERTIES
    let title: String
    let backgroundColor: UIColor
    let textFieldPromptText: String
    let placeholderText: String
    let segmentedControlPrompt: String
    let segmentedControlItemsText: [String]

    // MARK: - EVENTS
    let viewDidLoad = PublishRelay<Void>()
    let applyFilterButtonTap = PublishRelay<[APIParameters]>()
    let resetFilterButtonTap = PublishRelay<[APIParameters]>()

    // TODO: TEST RIDUCILO mudar esse nome
    let requestImage = PublishRelay<Int>()

    // MARK: - COSNTRUCTORS
    init(title: String,
         backgroundColor: UIColor,
         textFieldPromptText: String,
         nameLabelText: String,
         segmentedControlPrompt: String,
         segmentOptionListText: [String]) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.textFieldPromptText = textFieldPromptText
        self.placeholderText = nameLabelText
        self.segmentedControlPrompt = segmentedControlPrompt
        self.segmentedControlItemsText = segmentOptionListText
    }
}
