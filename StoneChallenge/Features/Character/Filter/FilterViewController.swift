//
//  FilterViewController.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class FilterViewController: UIViewController {

    // MARK: - VIEWS
    // In a normal situation all views should be created/configurated
    // by a viewModel, like, TextViewModel, ButtonViewModel
    private lazy var textFieldPromptLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.textFieldPromptText
        label.numberOfLines = 2
        return label
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = viewModel.placeholderText
        textField.text = viewModel.textFieldText ?? ""
        return textField
    }()

    private lazy var segmentedControlPromptLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.segmentedControlPrompt
        return label
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: viewModel.segmentOptionListText)
        segmentedControl.selectedSegmentIndex = viewModel.segmentSelectedIndex
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.7412293553, green: 1, blue: 0.631372549, alpha: 1)
        return segmentedControl
    }()

    private lazy var applyFilterButton: UIButton = {
        let applyFilterButton = UIButton()
        applyFilterButton.translatesAutoresizingMaskIntoConstraints = false
        applyFilterButton.setTitle(viewModel.applyFilterButtonTitle, for: .normal)
        applyFilterButton.setTitleColor(#colorLiteral(red: 0.03137254902, green: 0.03137254902, blue: 0.03137254902, alpha: 1), for: .normal)
        applyFilterButton.backgroundColor = #colorLiteral(red: 0.7412293553, green: 1, blue: 0.631372549, alpha: 1)
        return applyFilterButton
    }()

    private lazy var resetFilterButton: UIButton = {
        let resetFilterButton = UIButton()
        resetFilterButton.translatesAutoresizingMaskIntoConstraints = false
        resetFilterButton.setTitle(
            viewModel.resetFilterButtonTitle,
            for: .normal
        )
        resetFilterButton.setTitleColor(#colorLiteral(red: 0.03137254902, green: 0.03137254902, blue: 0.03137254902, alpha: 1), for: .normal)
        resetFilterButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return resetFilterButton
    }()

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: - PRIVATE PROPERTIES
    private let disposeBag = DisposeBag()

    // MARK: - INJECTED PROPERTIES
    let viewModelProvider: FilterViewModelProvider
    let viewModel: FilterViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.viewDidLoad.accept(())
    }

    // MARK: - CONSTRUCTORS
    init(viewModelProvider: FilterViewModelProvider) {
        self.viewModelProvider = viewModelProvider
        self.viewModel = viewModelProvider.viewModel
        super.init(nibName: nil, bundle: nil)

        bind()
        configure()
    }

    required init?(coder: NSCoder) { return nil }

    // MARK: - PRIVATE FUNCTIONS
    private func configure() {
        title = viewModel.title
        view.backgroundColor = viewModel.backgroundColor

        let stackView = UIStackView(
            arrangedSubviews: [
                UIStackView(
                    arrangedSubviews: [
                        textFieldPromptLabel,
                        textField,
                        segmentedControlPromptLabel,
                        segmentedControl
                    ],
                    axis: .vertical,
                    spacing: 16
                ),
                UIStackView(
                    arrangedSubviews: [
                        UIView(),
                        errorLabel,
                        resetFilterButton,
                        applyFilterButton
                    ],
                    axis: .vertical,
                    spacing: 16
                )
            ],
            axis: .vertical
        )

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            )
        ])
    }

    // MARK: - BIND
    private func bind() {

        applyFilterButton.rx.tap
            .subscribe { [self] _ in
                var param: [APIParameter] = []

                if let text = textField.text {
                    param.append(APIParameter.name(text))
                }

                if let label = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) {
                    let paramStatus = APIParameter.status(APIParameter.Status(rawValue: label))
                    param.append(paramStatus)
                }

                viewModel.applyFilterButtonTap.accept(param)
            }.disposed(by: disposeBag)

        resetFilterButton.rx.tap
            .subscribe { [self] _ in
                textField.text = ""
                segmentedControl.selectedSegmentIndex = -1
                errorLabel.text = ""
                viewModel.resetFilterButtonTap.accept([])
            }
            .disposed(by: disposeBag)

        viewModel.errorText
            .compactMap { $0 }
            .bind(to: errorLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct FilterViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            FilterViewController(
                viewModelProvider: FilterPresenter(
                    interactor: FilterInteractor(
                        webService: CharactersWebService()
                    ),
                    router: FilterRouter(
                        viewControllerFactory: UserDependencyContainer()
                    ),
                    filterCallBack: PublishSubject<FilterCallBack>(),
                    filterParameters: []
                )
            )
        }
    }
}
#endif
