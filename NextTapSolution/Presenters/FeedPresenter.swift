//
//  FeedPresenter.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/22/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import Foundation
import UIKit

class FeedPresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func startFetchingFeeds() {
        interactor?.fetchFeeds()
    }
}

extension FeedPresenter: InteractorToPresenterProtocol {
    func feedsFetchedSuccess(feeds: [NTFeed]) {
        view?.showFeeds(feeds: feeds)
    }
    
    func feedsFetchFailed(error: Error) {
        view?.showError(error: error)
    }
}
