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
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var likeContainerView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    private var isSizeCalculated: Bool = false
    
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

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if !isSizeCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isSizeCalculated = true
        }
        return layoutAttributes
    }
}
