//
//  ViewController.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/22/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import UIKit

enum ScreenType {
    case feeds
    case preview
}

class FeedsViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: ViewToPresenterProtocol?
    private var feeds = [NTFeed]()
    private var cellIdentifier = "FeedCellIdentifier"
    private let itemSpacing: CGFloat = 4
    private var screenType: ScreenType = .feeds
    private var selectedIndex = 0
    private var loadingIndicator = UIActivityIndicatorView(style: .large)
    private var scrolledToSelectedIndex = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if screenType == .feeds {
            title = "Stories"
            view.addSubview(loadingIndicator)
            loadingIndicator.center = view.center
            loadingIndicator.startAnimating()
            presenter?.startFetchingFeeds()
        } else {
            title = "Preview"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !scrolledToSelectedIndex {
            scrolledToSelectedIndex = true
            collectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    func set(screenType: ScreenType, selectedIndex: Int, feeds: [NTFeed]) {
        self.screenType = screenType
        self.selectedIndex = selectedIndex
        self.feeds = feeds
    }
    
    private func setupView() {
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        switch screenType {
        case .feeds:
            collectionView.showsVerticalScrollIndicator = false
        case .preview:
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = true
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissScreen))
        }
    }
    
    @objc private func dismissScreen() {
        dismiss(animated: true, completion: nil)
    }
}

extension FeedsViewController: PresenterToViewProtocol {
    func showFeeds(feeds: [NTFeed]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loadingIndicator.stopAnimating()
            self.feeds = feeds
            self.collectionView.reloadData()
        }
    }
    
    func showError(error: Error) {
        loadingIndicator.stopAnimating()
        processError(error: error)
    }
}

extension FeedsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if screenType == .feeds {
            let previewScreen = FeedRouter.createModule(type: .preview, selectedIndex: indexPath.row, feeds: feeds)
            let nav = UINavigationController(rootViewController: previewScreen)
            nav.modalPresentationStyle = .overFullScreen
            present(nav, animated: true, completion: nil)
        }
    }
}

extension FeedsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FeedCollectionViewCell
        cell.setData(feed: feeds[indexPath.row])
        return cell
    }
}

extension FeedsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch screenType {
        case .feeds:
            let itemWidth = (collectionView.frame.size.width - 3 * itemSpacing) / 2
            let itemHeight = collectionView.frame.size.height / 2
            return CGSize(width: itemWidth, height: itemHeight)
        default:
            return collectionView.frame.size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch screenType {
        case .feeds:
            return itemSpacing
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch screenType {
        case .feeds:
            return itemSpacing
        default:
            return 0
        }
    }
}
