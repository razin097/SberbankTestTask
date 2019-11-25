//
//  Network.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 22.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

class TableNetwork {

    private weak var delegate: TableViewModelDelegate?

    init(delegate: TableViewModelDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        print(#function, #file)
    }

    public func getJsonFromApi(searchWord: String) {
        let urlString = urlPrefix + "q=\(searchWord == "" ? "news" : searchWord)&from=\(fromDate)&sortBy=publishedAt&apiKey=\(apiKey)"
        
        // fixed bug with invalid data in url
        // was:
        // let url = URL(string: urlString)
        // now:
        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let url = URL(string: encoded) else { return }
        // all unicode symbols can be used now
        
        print(url)
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PublicationsStruct.self, from: data)
                let result = self.parsePublications(publs: response)
                self.delegate?.onReadyGettingDataFromApi(data: result)
            } catch { print(error) }
        })
        task.resume()
    }

    private func parsePublications(publs: PublicationsStruct) -> [Publication] {
        var arr: [Publication] = Array()

        for k in publs.articles {
            let newPublication = Publication(author: k?.author,
                title: k?.title,
                description: k?.description,
                publishedAt: k?.publishedAt,
                urlToPublication: k?.url,
                urlToImage: k?.urlToImage)

            arr.append(newPublication)
        }
        return arr
    }
}
