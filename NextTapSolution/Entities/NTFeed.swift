//
//  NTFeed.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/22/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import Foundation

struct NTFeedResponse: Decodable {
    let data: [NTFeed]
}

struct NTFeed: Decodable {
    let id: String
    let shortId: String
    let revision: Int
    let user: NTUser
    let version: Int
    let coverSrc: String
    let coverBg: String
    let shareUrl: String
    let landscapeShareImage: String
    let feedPreviewVideo: String?
    let pageCount: Int
    let title: String
    let snippet: NTSnipet
    let collectionCount: Int
    let commentCount: Int
    let canonicalPin: Int?
    let aspectRatio: String?
    let storyTypeId: String?
    let storyType: String?
    let coverLarge: String
    let coverSmall: String
    let likes: NTLike
    let isPrivate: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case shortId = "short_id"
        case revision
        case user
        case version
        case coverSrc = "cover_src"
        case coverBg = "cover_bg"
        case shareUrl = "share_url"
        case landscapeShareImage = "landscape_share_image"
        case feedPreviewVideo = "feed_preview_video"
        case pageCount = "page_count"
        case title
        case snippet
        case collectionCount = "collection_count"
        case commentCount = "comment_count"
        case canonicalPin = "canonical_pin"
        case aspectRatio = "aspect_ratio"
        case storyTypeId = "story_type_id"
        case storyType = "story_type"
        case coverLarge = "cover_src_320x480"
        case coverSmall = "cover_src_160x240"
        case likes
        case isPrivate = "private"
    }
}

struct NTLike: Decodable {
    let count: Int
    let currentUser: Bool
    
    private enum CodingKeys: String, CodingKey {
        case count
        case currentUser = "current_user"
    }
}
