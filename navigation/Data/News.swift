//
//  News.swift
//  navigation
//
//  Created by Max Egorov on 3/26/22.
//

import Foundation

struct News: Decodable {

    struct Article: Decodable  {
        let author: String
        let description: String
        let image: String
        let likes: String
        let views: String

        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }
    }

    let articles: [Article] 
}
