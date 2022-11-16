//
//  ViewController.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 14/11/22.
//

import UIKit

class CharactersViewController: UIViewController {

    // MARK: - VIEWS
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints  = false
        collectionView.backgroundColor = .white
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "collectionCell"
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 6
        return collectionView
    }()

    // MARK: - INJECTED PROPERTIES
    let viewModelProvider: CharactersViewModelProvider
    let viewModel: CharactersViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - CONSTRUCTORS
    init(viewModelProvider: CharactersViewModelProvider) {
        self.viewModelProvider = viewModelProvider
        self.viewModel = viewModelProvider.viewModel
        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder: NSCoder) { return nil }

    // MARK: - PRIVATE FUNCTIONS
    private func configure() {
        view.backgroundColor = .green
        self.view.addSubview(self.collectionView)

        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 25
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CharactersViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharactersViewController: UICollectionViewDelegateFlowLayout {

    private var sectionInsets: UIEdgeInsets {
       UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    private var itemsPerRow: CGFloat {
       return 3
    }

    private var itemsPerColumn: CGFloat {
        return 4
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

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CharactersViewController(
                viewModelProvider: CharactersPresenter(
                    interactor: CharactersInteractor(),
                    router: CharactersRouter(),
                    characterList: []
                )
            )
        }
    }
}
#endif
