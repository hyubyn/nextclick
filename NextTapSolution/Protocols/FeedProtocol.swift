//
//  FeedProtocol.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/22/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import UIKit
import Foundation

protocol ViewToPresenterProtocol: class{
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    func startFetchingFeeds()
}

protocol PresenterToViewProtocol: class{
    func showFeeds(feeds: [NTFeed])
    func showError(error: Error)
}

protocol PresenterToRouterProtocol: class {
    static func createModule(type: ScreenType, selectedIndex: Int, feeds: [NTFeed]) -> FeedsViewController
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? { get set }
    func fetchFeeds()
}

protocol InteractorToPresenterProtocol: class {
    func feedsFetchedSuccess(feeds: [NTFeed])
    func feedsFetchFailed(error: Error)
}
