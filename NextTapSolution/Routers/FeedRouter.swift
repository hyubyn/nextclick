//
//  FeedRouter.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/23/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import UIKit

class FeedRouter: PresenterToRouterProtocol {
    static func createModule(type: ScreenType, selectedIndex: Int, feeds: [NTFeed]) -> FeedsViewController {
        let view = mainStoryboard.instantiateViewController(identifier: "FeedsViewController") as? FeedsViewController
        view?.set(screenType: type, selectedIndex: selectedIndex, feeds: feeds)
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = FeedPresenter()
        let interactor: PresenterToInteractorProtocol = FeedInteractor()
        let router: PresenterToRouterProtocol = FeedRouter()
        view?.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        return view!
    }
    
    static var mainStoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
