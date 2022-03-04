//
//  Articles.swift
//  navigation
//
//  Created by Max Egorov on 2/28/22.
//

import Foundation

struct Articles: Decodable { // Создаем структуру Post

    struct Article: Decodable  {
        var title: String
        var description: String
        var image: String
        var likes: String
        var views: String

        enum CodingKeys: String, CodingKey {
            case title, description, image, likes, views
        }
    }

    let articles: [Article]
}
