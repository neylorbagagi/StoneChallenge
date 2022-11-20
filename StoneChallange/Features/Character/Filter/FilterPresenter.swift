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

    //public let filterParams = PublishRelay<[APIParameters]>()

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
    var filterParameters: [APIParameters]?
    let filterCallBack: PublishSubject<FilterCallBack>

    init(interactor: FilterInteractor,
         router: FilterRouter,
         filterCallBack: PublishSubject<FilterCallBack>,
         filterParameters: [APIParameters]?) {

        self.interactor = interactor
        self.router = router
        self.filterCallBack = filterCallBack
        self.filterParameters = filterParameters

        bind()
    }

    // MARK: - PRIVATE FUNCTIONS
    func segmentOptionListText() -> [String] {
        APIParameters.Status.allCases.map { $0.rawValue }
    }

    // MARK: - BIND
    private func bind() {

        viewModel.applyFilterButtonTap
            .subscribe(onNext: { [self] in
                filterParameters = $0
                interactor.requestFilterData.accept($0)
            }).disposed(by: disposeBag)

        viewModel.resetFilterButtonTap
            .subscribe(onNext: { [self] in
                filterParameters = $0
                interactor.requestFilterData.accept($0)
            }).disposed(by: disposeBag)

        interactor.responseFilterData
            .map { [self] in FilterCallBack(data: $0, parameters: filterParameters) }
            .bind(to: filterCallBack)
            .disposed(by: disposeBag)

        interactor.responseFilterData
            .map { _ in }
            .bind(to: router.pop)
            .disposed(by: disposeBag)
    }
}
