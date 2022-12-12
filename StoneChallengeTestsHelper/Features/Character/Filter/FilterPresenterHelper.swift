//
//  FilterPresenterHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 28/11/22.
//

import Foundation
import RxSwift
@testable import StoneChallenge

extension FilterPresenter {
    public static func mock(
        interactor: FilterInteractor = .mock(),
        router: FilterRouter = .mock(),
        filterCallBack: PublishSubject<FilterCallBack> = .init(),
        filterParameters: [APIParameter] = .init()
    ) -> FilterPresenter {
        .init(
            interactor: interactor,
            router: router,
            filterCallBack: filterCallBack,
            filterParameters: filterParameters
        )
    }
}
