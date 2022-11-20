//
//  FilterPresenter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation
import RxSwift

class FilterPresenter: FilterViewModelProvider {

    let disposeBag = DisposeBag()

    // MARK: - VIEW MODELS
    lazy var viewModel: FilterViewModel = {
        FilterViewModel(
            title: NSLocalizedString("filter_presenter_title", comment: ""),
            backgroundColor: .white,
            textFieldPromptText: NSLocalizedString("filter_presenter_textField_prompt_text", comment: ""),
            nameLabelText: NSLocalizedString("filter_presenter_nameLabel_text", comment: ""),
            segmentedControlPrompt: NSLocalizedString("filter_presenter_segmentedControl_prompt_text", comment: ""),
            segmentOptionListText: segmentOptionListText()
        )
    }()

    let interactor: FilterInteractor
    let router: FilterRouter

    init(interactor: FilterInteractor,
         router: FilterRouter) {

        self.interactor = interactor
        self.router = router

        bind()
    }

    // MARK: - PRIVATE FUNCTIONS
    func segmentOptionListText() -> [String] {
        APIParameters.Status.allCases.map { $0.rawValue }
    }

    // MARK: - BIND
    private func bind() {
        viewModel.applyFilterButtonTap
            .bind(to: router.pop)
            .disposed(by: disposeBag)

    }
}
