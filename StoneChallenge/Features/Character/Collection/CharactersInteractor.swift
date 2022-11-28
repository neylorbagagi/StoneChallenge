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

    public typealias PageURL = String
    public typealias Position = Int

    // MARK: - SUBJECTS
    public let requestPageData = PublishRelay<PageURL>()
    public let responsePageData = PublishRelay<Result<DataInfo<Character>, Error>>()

    public let requestImageData = PublishRelay<(Position, PageURL)>()
    public let responseImageData = PublishRelay<(Position, UIImage)>()

    // MARK: - PRIVATE PROPERTIES
    private let disposeBag = DisposeBag()

    // MARK: - INJECTED PROPERTIES
    let webService: CharactersWebServiceType
    let cache: ImageCacheProtocol

    // MARK: - CONSTRUCTORS
    init(webService: CharactersWebServiceType,
         cache: ImageCacheProtocol) {
        self.webService = webService
        self.cache = cache
        bind()
    }

    // MARK: - PRIVATE FUNCTIONS
    private func fetchPageData(byString urlString: String) {
        webService.getCharacters(byPage: urlString) { [self] result in
            responsePageData.accept(result)
        }
    }

    private func fetchImage(byString urlString: String, index: Int) {
        guard let url = NSURL(string: urlString) else { return }
        cache.load(url: url) { [self] image in
            return responseImageData.accept((index, image ?? cache.placeholderImage))
        }
    }

    // MARK: - BIND
    func bind() {
        requestPageData
            .subscribe { [self] urlString in
                fetchPageData(byString: urlString)
            }.disposed(by: disposeBag)

        requestImageData
            .subscribe { [self] position, urlString in
                fetchImage(byString: urlString, index: position)
            }.disposed(by: disposeBag)

    }
}
