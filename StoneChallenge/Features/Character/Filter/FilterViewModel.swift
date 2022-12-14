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
    let textFieldText: String?

    let segmentedControlPrompt: String
    let segmentOptionListText: [String]
    let segmentSelectedIndex: Int

    let applyFilterButtonTitle: String
    let resetFilterButtonTitle: String

    let errorText: BehaviorRelay<String?>

    // MARK: - EVENTS
    let viewDidLoad = PublishRelay<Void>()
    let applyFilterButtonTap = PublishRelay<[APIParameter]>()
    let resetFilterButtonTap = PublishRelay<[APIParameter]>()

    // MARK: - COSNTRUCTORS
    init(title: String,
         backgroundColor: UIColor,
         textFieldPromptText: String,
         placeholderText: String,
         textFieldText: String?,
         segmentedControlPrompt: String,
         segmentOptionListText: [String],
         segmentSelectedIndex: Int,
         applyFilterButtonTitle: String,
         resetFilterButtonTitle: String,
         errorText: String?) {
        self.title = title
        self.backgroundColor = backgroundColor

        self.textFieldPromptText = textFieldPromptText
        self.placeholderText = placeholderText
        self.textFieldText = textFieldText

        self.segmentedControlPrompt = segmentedControlPrompt
        self.segmentOptionListText = segmentOptionListText
        self.segmentSelectedIndex = segmentSelectedIndex

        self.applyFilterButtonTitle = applyFilterButtonTitle
        self.resetFilterButtonTitle = resetFilterButtonTitle

        self.errorText = BehaviorRelay<String?>.init(value: errorText)
    }
}
