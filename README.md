# OVERVIEW

> This is the small project which uses VIPER architecture and DI

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Dependency Injection](#dependency)

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
---

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**

