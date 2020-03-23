//
//  NTUser.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/22/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import Foundation

struct NTUser: Decodable {
    let id: String
    let revision: Int
    let displayName: String
    let avatarImageUrl: String
    let avatarImageBg: String
    let headerImageBg: String
    let followers: Int
    let following: Int
    let explicitlyFollowed: Bool
    let implicitlyFollowed: Bool
    let followsYou: Bool
    let blocked: Bool
    let stories: Int
    let followRequestSent: Bool
    let followRequestReceived: Bool
    let userName: String
    let isPrivate: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case revision
        case displayName = "display_name"
        case avatarImageUrl = "avatar_image_url"
        case avatarImageBg = "avatar_image_bg"
        case headerImageBg = "header_image_bg"
        case followers
        case following
        case explicitlyFollowed = "explicitly_followed"
        case implicitlyFollowed = "implicitly_followed"
        case followsYou = "follows_you"
        case blocked
        case stories
        case followRequestSent = "follow_request_sent"
        case followRequestReceived = "follow_request_received"
        case userName = "_username"
        case isPrivate = "private"
    }
}
