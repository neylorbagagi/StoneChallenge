//
//  ViewController.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 14/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class CharactersViewController: UIViewController {

    let disposeBag = DisposeBag()

    // MARK: - VIEWS
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints  = false
        collectionView.backgroundColor = .white
        collectionView.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier
        )
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - INJECTED PROPERTIES
    let viewModelProvider: CharactersViewModelProvider
    let viewModel: CharactersViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.viewDidLoad.accept(())
    }

    // MARK: - CONSTRUCTORS
    init(viewModelProvider: CharactersViewModelProvider) {
        self.viewModelProvider = viewModelProvider
        self.viewModel = viewModelProvider.viewModel
        super.init(nibName: nil, bundle: nil)

        bind()
        configure()
    }

    required init?(coder: NSCoder) { return nil }

    // MARK: - PRIVATE FUNCTIONS
    private func configure() {
        self.view.addSubview(self.collectionView)

        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    // MARK: - BIND
    private func bind() {
        viewModel.cellViewModels
            .bind(to: collectionView.rx.items(
                    cellIdentifier: CharacterCollectionViewCell.reuseIdentifier,
                    cellType: CharacterCollectionViewCell.self)) { _, viewModel, cell in
                cell.configure(viewModel: viewModel)
            }.disposed(by: disposeBag)

        // TODO: melhorar isso que tá triste
        collectionView.rx.willDisplayCell
            .subscribe { [self] _, indexPath in
                if viewModel.cellViewModels.value.count - 1 == indexPath.row {
                    self.viewModel.collectionViewDidHitBottom.accept(())
                }
            }.disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.collectionViewDidSelectItem)
            .disposed(by: disposeBag)
    }
}

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharactersViewController: UICollectionViewDelegateFlowLayout {

    private var sectionInsets: UIEdgeInsets {
       UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    private var itemsPerRow: CGFloat {
       return 3
    }

   private var itemsOriginalWidth: CGFloat { return 300 } /// Using the original size of the poster
   private var itemsOriginalHeight: CGFloat { return 300 } /// Using the original size of the poster
   private var footerInSectionSize: CGFloat { return 59 }

   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {

       /// ??? find out origin of this value:4
       let collectionWidth = collectionView.frame.width - 4

       /// Calculate width
       let widthPaddingSpace = self.sectionInsets.left * (self.itemsPerRow + 1)
       let widthAvailable = collectionWidth - widthPaddingSpace
       let widthForItem = widthAvailable/self.itemsPerRow

       /// Calculate height proportion by its width
       /// Formula (original height / original width) x new width = new height
       let heightForItem = (self.itemsOriginalHeight/self.itemsOriginalWidth)*widthForItem
       return CGSize(width: widthForItem, height: heightForItem)
   }

   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       insetForSectionAt section: Int) -> UIEdgeInsets {
       return self.sectionInsets
   }

   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return self.sectionInsets.top
   }

   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       referenceSizeForFooterInSection section: Int) -> CGSize {
       return CGSize(width: collectionView.frame.width, height: self.footerInSectionSize)
   }
}
// TODO: da pra trazer isso do presenter

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CharactersViewController(
                viewModelProvider: CharactersPresenter(
                    interactor: CharactersInteractor(
                        webService: CharactersWebService()
                    ),
                    router: CharactersRouter(
                        viewControllerFactory: UserDependencyContainer()
                    ),
                    characterList: []
                )
            )
        }
    }
}
#endif
