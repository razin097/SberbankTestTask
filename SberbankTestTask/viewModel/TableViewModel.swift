//
//  TableViewModel.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 14.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation


class TableViewModel: TableViewModelType {
    
    //MARK: - var, let, property
    private var delegate:UpdateTableDelegate?
    private var publications: [Publication]?
    private var maxNumberOfRows = numberOfRowsInEachPart
    
    //MARK: - init
    required init(delegate:UpdateTableDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - rows counting
    var numberOfRows: Int {
        guard let publications = publications else {return 0}
        if publications.count > self.maxNumberOfRows {
            return maxNumberOfRows
        }
        return publications.count
    }
    
    func resetMaxNumberOfRows(){
        self.maxNumberOfRows = numberOfRowsInEachPart
    }

    func getPublication(forRow: Int) -> Publication? {
        return publications?[forRow]
    }
    
    //MARK: - json get & parse
    public func refreshData(searchWord: String) {
        //q=bitcoin&from=2019-10-13&sortBy=publishedAt&apiKey=
        let urlString = urlPrefix + "q=\(searchWord == "" ? "news" : searchWord)&from=\(fromDate)&sortBy=publishedAt&apiKey=\(apiKey)"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PublicationsStruct.self, from: data)
                    self.parsePublications(publs: response)
                } catch { print(error) }
            })
        task.resume()
    }

    private func parsePublications(publs: PublicationsStruct) {
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
    
    //MARK: - load more
    func loadMore(searchWord: String?){
        if self.moreRows() == true {
            self.refreshData(searchWord: searchWord ?? defaultSearchWord)
        }
    }
    
    func moreRows() -> Bool {
        let buf = self.maxNumberOfRows
        self.maxNumberOfRows += numberOfRowsInEachPart
        if self.maxNumberOfRows > maxNumberOfRowsInTable {
            self.maxNumberOfRows = maxNumberOfRowsInTable
        }
        return buf != self.maxNumberOfRows
    }
    
    //MARK: - view models
    func cellViewModel(forRow: Int) -> TableCellViewModelType {
        let publication:Publication? = publications?[forRow]
        return TableCellViewModel(publication: publication)
    }
    
    func detailViewModel(forRow: Int) -> DetailViewModelType {
        let publication:Publication? = publications?[forRow]
        return DetailViewModel(publication: publication)
    }
    
    //MARK: - delegate
    private func updateTable() {
        DispatchQueue.main.async {
            self.delegate?.onReadyDataLoad()
        }
    }

}
