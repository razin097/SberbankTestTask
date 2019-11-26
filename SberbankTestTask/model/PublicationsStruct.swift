//
//  PublicationsStruct.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 14.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

// struct for parse json
struct PublicationsStruct: Codable {

    let status: String?
    let totalResults: Int?
    struct Articles: Codable {
        struct Sourse: Codable {
            let id: String?
            let name: String?
        }

        let author: String?
        let content: String?
        let description: String?
        let publishedAt: String?

        let title: String?
        let url: String?
        let urlToImage: String?
        let sourse: Sourse?
    }
    let articles: [Articles?]

}
