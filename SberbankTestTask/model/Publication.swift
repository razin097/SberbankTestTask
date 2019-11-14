//
//  NewsUnit.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 14.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation


class Publication {
    let author:String?
    let title:String?
    let description:String?
    let publishedAt:String?
    let urlToPublication:String?
    let urlToImage:String?
    
    internal init(author: String?, title: String?, description: String?, publishedAt: String?, urlToPublication: String?, urlToImage: String?) {
        self.author = author
        self.title = title
        self.description = description
        self.publishedAt = publishedAt
        self.urlToPublication = urlToPublication
        self.urlToImage = urlToImage
    }
}


//"source": {
//"id": null,
//"name": "Newsbtc.com"
//},
//"author": "Cole Petersen",
//"title": "Par for the Course: Bitcoin Difficulty Drop Actually a Bullish Sign",
//"description": "Bitcoin has once again found itself caught within a bout of consolidation as it ranges sideways above its key near-term support level at $8,700. Despite BTC’s recent sell-off that sent it reeling below $9,000, the cryptocurrency’s bulls have been able to defe…",
//"url": "https://www.newsbtc.com/2019/11/13/par-for-the-course-bitcoin-difficulty-drop-actually-a-bullish-sign/",
//"urlToImage": "https://www.newsbtc.com/wp-content/uploads/2019/10/shutterstock_554244451-6-1200x780.jpg",
//"publishedAt": "2019-11-13T21:00:23Z",
//"content": "Bitcoin has once again found itself caught within a bout of consolidation as it ranges sideways above its key near-term support level at $8,700. Despite BTCs recent sell-off that sent it reeling below $9,000, the cryptocurrencys bulls have been able to defend… [+2409 chars]"
