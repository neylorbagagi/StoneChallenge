//
//  FilterInteractor.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation
import RxSwift
import RxRelay

class FilterInteractor {

    let disposeBag = DisposeBag()

    let requestFilterData = PublishRelay<[APIParameters]>()
    let responseFilterData = PublishSubject<DataInfo<Character>>()

    let webService: CharactersWebService

    init(webService: CharactersWebService) {
        self.webService = webService
        bind()
    }

    private func fetchFilterData(parameters params: [APIParameters]) {

        webService.getCharacters(parameters: params) { [self] result in
            switch result {
            case .success(let dataInfo):
                responseFilterData.onNext(dataInfo)
            case .failure(let error):
                responseFilterData.onError(error)
            }
        }
    }

    func bind() {
        requestFilterData
            .subscribe { [self] params in
                fetchFilterData(parameters: params)
            }.disposed(by: disposeBag)
    }
}
