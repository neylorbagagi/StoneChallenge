//
//  FilterPresenter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class FilterPresenter: FilterViewModelProvider {

    private let disposeBag = DisposeBag()

    // MARK: - VIEW MODELS
    lazy var viewModel: FilterViewModel = {
        FilterViewModel(
            title: NSLocalizedString(
                "filter_presenter_title",
                comment: ""
            ),
            backgroundColor: .white,
            textFieldPromptText: NSLocalizedString(
                "filter_presenter_textField_prompt_text",
                comment: ""
            ),
            placeholderText: NSLocalizedString(
                "filter_presenter_nameLabel_text",
                comment: ""
            ),
            textFieldText: textFieldText(),
            segmentedControlPrompt: NSLocalizedString(
                "filter_presenter_segmentedControl_prompt_text",
                comment: ""
            ),
            segmentOptionListText: segmentOptionListText(),
            segmentSelectedIndex: segmentSelectedIndex(),
            applyFilterButtonTitle: NSLocalizedString(
                "filter_view_controller_applyFilter_button",
                comment: ""
            ),
            resetFilterButtonTitle: NSLocalizedString(
                "filter_view_controller_resetFilter_button",
                comment: ""
            ),
            errorText: nil
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
    private func segmentOptionListText() -> [String] {
        APIParameters.Status.allCases.map { $0.rawValue }
    }

    private func textFieldText() -> String? {
        filterParameters?.first(where: { $0.describe() == "name" })?.getValue()
    }

    private func segmentSelectedIndex() -> Int {
        guard let value = filterParameters?.first(where: { $0.describe() == "status" })?.getValue() else { return -1 }
        return APIParameters.Status(rawValue: value)?.getPosition() ?? -1
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
            .subscribe(onNext: { [self] result in
                switch result {
                case .success(let data):
                    filterCallBack.onNext(FilterCallBack(data: data, parameters: filterParameters))
                    router.pop.accept(())
                case .failure:
                    viewModel.errorText.accept(NSLocalizedString(
                        "filter_presenter_not_found_error",
                        comment: ""
                    ))
                }
            })
            .disposed(by: disposeBag)
    }
}
