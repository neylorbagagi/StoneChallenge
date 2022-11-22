//
//  CharacterInteractor.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class CharacterInteractor {

    typealias ImageURL = String

    // MARK: - PRIVATE PROPERTIES
    private let disposeBag = DisposeBag()

    // MARK: - SUBJECTS
    let requestImageData = PublishRelay<ImageURL>()
    let responseImageData = PublishSubject<UIImage>()

    // MARK: - INJECTED PROPERTIES
    let cache: ImageCache

    // MARK: - CONSTRUCTORS
    init(cache: ImageCache) {
        self.cache = cache
        bind()
    }

    // MARK: - PRIVATE FUNCTIONS
    private func fetchImage(byString urlString: String) {
        guard let url = NSURL(string: urlString) else { return }
        cache.load(url: url) { [self] image in
            if let image = image {
                responseImageData.onNext(image)
            } else {
                responseImageData.onNext(cache.placeholderImage)
            }
        }
    }

    // MARK: - BIND
    private func bind() {
        requestImageData
            .subscribe { [self] urlString in
                fetchImage(byString: urlString)
            }.disposed(by: disposeBag)
    }
}
