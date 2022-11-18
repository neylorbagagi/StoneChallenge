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

    let disposeBag = DisposeBag()

    let requestImageData = PublishRelay<ImageURL>()
    let responseImageData = PublishSubject<UIImage>()

    let cache: ImageCache

    init(cache: ImageCache) {
        self.cache = cache
        bind()
    }

    func fetchImage(byString urlString: String) {
        guard let url = NSURL(string: urlString) else { return }
        cache.load(url: url) { [self] image in
            if let image = image {
                responseImageData.onNext(image)
            } else {
                responseImageData.onNext(cache.placeholderImage)
            }
        }
    }

    func bind() {
        requestImageData
            .subscribe { [self] urlString in
                fetchImage(byString: urlString)
            }.disposed(by: disposeBag)
    }
}
