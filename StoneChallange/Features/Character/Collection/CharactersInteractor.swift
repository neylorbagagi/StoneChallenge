//
//  CharactersInteractor.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import RxRelay
import RxSwift
import UIKit

class CharactersInteractor {

    typealias PageURL = String

    let disposeBag = DisposeBag()

    let requestPageData = PublishRelay<PageURL>()
    let responsePageData = PublishSubject<DataInfo<Character>>()


    let getImage = PublishRelay<(Int, PageURL)>()
    let responseImage = PublishRelay<(Int, UIImage)>()



    let webService: CharactersWebService
    let cache: ImageCache

    init(webService: CharactersWebService,
         cache: ImageCache) {
        self.webService = webService
        self.cache = cache
        bind()
    }

    private func fetchPageData(byString urlString: String) {

        webService.getCharacters(byPage: urlString) { [self] result in
            switch result {
            case .success(let dataInfo):
                responsePageData.onNext(dataInfo)
            case .failure(let error):
                responsePageData.onError(error)
            }
        }
    }

    private func fetchImage(byString urlString: String, index: Int) {

        guard let url = NSURL(string: urlString) else { return }
        cache.load(url: url) { [self] image in
            if let image = image {
                return responseImage.accept((index, image))
            } else {
                return responseImage.accept((index, cache.placeholderImage))
            }
        }
    }

    func bind() {
        requestPageData
            .subscribe { [self] urlString in
                fetchPageData(byString: urlString)
            }.disposed(by: disposeBag)

        getImage
            .subscribe { [self] position, urlString in
                fetchImage(byString: urlString, index: position)
            }.disposed(by: disposeBag)
    }
}
