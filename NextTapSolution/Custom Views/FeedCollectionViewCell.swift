//
//  FeedCollectionViewCell.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/23/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import UIKit
import SDWebImage

class FeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var likeContainerView: UIView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .clear
        coverImageView.layer.cornerRadius = 5
    }

    func setData(feed: NTFeed) {
        coverImageView.sd_setImage(with: URL(string: feed.coverSrc), completed: nil)
        userNameLabel.text = feed.user.displayName
        if feed.likes.count > 0 {
            likeContainerView.isHidden = false
            likeCountLabel.text = "\(feed.likes.count)"
        } else {
            likeContainerView.isHidden = true
        }
    }
}
