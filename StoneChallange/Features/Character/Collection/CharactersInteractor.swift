//
//  CharactersInteractor.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation
import RxRelay
import RxSwift

class CharactersInteractor {

    typealias PageURL = String

    let disposeBag = DisposeBag()

    let requestPageData = PublishRelay<PageURL>()
    let responsePageData = PublishSubject<DataInfo<Character>>()

    let webService: CharactersWebService

    init(webService: CharactersWebService) {
        self.webService = webService
        bind()
    }

    func fetchPageData(byString urlString: String) {

        webService.getCharacters(byPage: urlString) { [self] result in
            switch result {
            case .success(let dataInfo):
                responsePageData.onNext(dataInfo)
            case .failure(let error):
                responsePageData.onError(error)
            }
        }
    }

    func bind() {
        requestPageData
            .subscribe { [self] urlString in
                fetchPageData(byString: urlString)
            }.disposed(by: disposeBag)
    }
}
