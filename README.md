# OVERVIEW

> This is the small project which uses VIPER architecture and DI

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Dependency Injection](#dependency)
- [Test](#test)

## Features

- Show list of stories
- Preview stories

## Architecture

The VIPER is the architecture which is used in this project. 
- FeedsViewController - has a collectionView to display stories for two `ScreenType`:
  - `feeds`: Display stories in horizontal direction
  - `preview`: Display stories in vertical direction with pagination
- View: There're two functions to update the view by the result from presenter
  - `showFeeds`
  - `showError`
- Interactor: FeedInteractor which calls functions from Network layers to get stories and then send the result to presenter via two functions
  - `feedsFetchedSuccess`
  - `feedsFetchFailed`
- Presenter: FeedPresenter which calls functions from FeedInteractor and then calls funtion to update the UI followed the result from interactor
  - `startFetchingFeeds`
- Entities:
  - NTFeed
  - NTLike
  - NTUser
  - NTSnipet
  - NTEntities
  - NTHashtag
- Router: FeedRouter

---
## Dependency Injection 
> Setter injection is used to init FeedViewController with the list of stories and the selected index to be shown for preview mode
```javascript
func set(screenType: ScreenType, selectedIndex: Int, feeds: [NTFeed]) {
        self.screenType = screenType
        self.selectedIndex = selectedIndex
        self.feeds = feeds
    }
```
This function indicate which type of screen is being used (screenType) and if the screenType is preview, we will use the selectedIndex to show the selected story, and the datasource is feeds - which is fetched from the previous screen so we don't have to make a network call again.

```javascript
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

```
---

## Test
> Use unit test to test if dependency injection works
```javascript
func testInitFeedHomeViewController() {
        let feedsVC = FeedRouter.createModule(type: .feeds, selectedIndex: 0, feeds: [])
        feedsVC.loadViewIfNeeded()
        XCTAssertEqual(feedsVC.title, ScreenType.feeds.rawValue)
    }
    
    func testInitFeedPreviewViewController() {
        let feedsVC = FeedRouter.createModule(type: .preview, selectedIndex: 0, feeds: [])
        feedsVC.loadViewIfNeeded()
        XCTAssertEqual(feedsVC.title, ScreenType.preview.rawValue)
    }
```

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**

