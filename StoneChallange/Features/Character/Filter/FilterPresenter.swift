//
//  FilterPresenter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation
import RxSwift
import RxRelay

class FilterPresenter: FilterViewModelProvider {

    let disposeBag = DisposeBag()

    public let filterParams = PublishRelay<[APIParameters]>()

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
    let filterCallBack: PublishSubject<DataInfo<Character>>

    init(interactor: FilterInteractor,
         router: FilterRouter,
         filterCallBack: PublishSubject<DataInfo<Character>>) {

        self.interactor = interactor
        self.router = router
        self.filterCallBack = filterCallBack

        bind()
    }

    // MARK: - PRIVATE FUNCTIONS
    func segmentOptionListText() -> [String] {
        APIParameters.Status.allCases.map { $0.rawValue }
    }

    // MARK: - BIND
    private func bind() {
        viewModel.applyFilterButtonTap
            .bind(to: interactor.requestFilterData)
            .disposed(by: disposeBag)

        interactor.responseFilterData
            .bind(to: filterCallBack)
            .disposed(by: disposeBag)

//        interactor.responseFilterData
//            .map { _ in }
//            .bind(to: router.pop)
//            .disposed(by: disposeBag)
    }
}
