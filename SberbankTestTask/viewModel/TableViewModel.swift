//
//  TableViewModel.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 14.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation


class TableViewModel: TableViewModelType {
    
    var delegate:UpdateTableDelegate?
    
    init(delegate:UpdateTableDelegate) {
        self.delegate = delegate
    }
    
    
    var numberOfRows: Int {
        guard let publications = publications else {return 0}
        if publications.count > numberOfRowsInEachPart {
            return numberOfRowsInEachPart
        }
        return publications.count
    }
    var publications: [Publication]?
    

    func getPublication(forRow: Int) -> Publication? {
        return publications?[forRow]
    }


    func getJsonFromApi(searchWord: String) {
        //q=bitcoin&from=2019-10-13&sortBy=publishedAt&apiKey=
        let url = urlPrefix + "q=\(searchWord)&from=\(fromDate)&sortBy=publishedAt&apiKey=\(apiKey)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in

                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PublicationsStruct.self, from: data)
                    print(response)
                    self.parsePublications(publs: response)
                } catch { print(error) }
            })
        task.resume()
    }

    func parsePublications(publs: PublicationsStruct) {
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
        self.publications = arr
        self.updateTable()
    }

    func updateTable() {
        delegate?.onReadyDataLoad()
    }

    func getPublicationsFromApi(searchWord: String = defaultSearchWord, maxCount: Int = numberOfRowsInEachPart) {
        getJsonFromApi(searchWord: searchWord)
    }

}



//func jsonToDict(json: Any?) {
//    // data we are getting from network request
//
//    print(json ?? "")
//    guard let jsonDict = json as? [String: [String: Any]] else {
//            print("Error in ", #function)
//            return
//    }
//
//    print(jsonDict)
//
//}


//                do {
//                    if let data = data {
//                        do {
//                            let jsonResponse = try JSONSerialization.jsonObject(with:
//                                    data, options: [])
//                            self.jsonToDict(json: jsonResponse)
//                        } catch let parsingError {
//                            print("Parsing Error", parsingError)
//                        }
//                    }
//                }
