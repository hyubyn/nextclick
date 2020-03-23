//
//  NTSnipet.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/22/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import Foundation

struct NTSnipet: Decodable {
    let text: String
    let entities: NTEntities
}

struct NTEntities: Decodable {
    let hashtags: [NTHashtag]
    let urls: [String]
    let users: [NTUser]
}

struct NTHashtag: Decodable {
    let hashtag: String
    let indices: [Int]
}
