//
//  Data.swift
//  Day 21 API Request
//
//  Created by Eth Os on 18/03/1443 AH.
//

import Foundation

struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

var postsArray = [Post]()
