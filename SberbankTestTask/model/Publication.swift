//
//  NewsUnit.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 14.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

class Publication {
    
    let author: String?
    let title: String?
    let description: String?
    let publishedAt: String?
    let urlToPublication: String?
    let urlToImage: String?

    internal init(author: String?, title: String?, description: String?, publishedAt: String?, urlToPublication: String?, urlToImage: String?) {
        self.author = author
        self.title = title
        self.description = description
        self.publishedAt = publishedAt
        self.urlToPublication = urlToPublication
        self.urlToImage = urlToImage
    }
    
}
