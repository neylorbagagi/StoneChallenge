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

    // MARK: - PRIVATE PROPERTIES
    private let disposeBag = DisposeBag()

    // MARK: - SUBJECTS
    let requestFilterData = PublishRelay<[APIParameters]>()
    let responseFilterData = PublishRelay<Result<DataInfo<Character>, Error>>()

    // MARK: - INJECTED PROPERTIES
    let webService: CharactersWebServiceType

    // MARK: - CONSTRUCTORS
    init(webService: CharactersWebServiceType) {
        self.webService = webService
        bind()
    }

    // MARK: - PRIVATE FUNCTIONS
    private func fetchFilterData(parameters params: [APIParameters]) {
        webService.getCharacters(parameters: params) { [self] result in
            responseFilterData.accept(result)
        }
    }

    // MARK: - BIND
    private func bind() {
        requestFilterData
            .subscribe { [self] params in
                fetchFilterData(parameters: params)
            }.disposed(by: disposeBag)
    }
}
