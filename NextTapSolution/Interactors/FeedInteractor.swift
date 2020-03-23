//
//  FeedInteractor.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/23/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

class FeedInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    func fetchFeeds() {
        NetworkManager.shared.getStories { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let feedResponse):
                self.presenter?.feedsFetchedSuccess(feeds: feedResponse.data)
            case .failure(let error):
                self.presenter?.feedsFetchFailed(error: error)
            }
        }
    }
}
