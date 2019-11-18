//
//  TableCellViewModel.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 15.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

class TableCellViewModel: TableCellViewModelType {

    //MARK: - var, let, property
    internal let publication: Publication?

    //MARK: - init
    required init (publication: Publication?) {
        self.publication = publication
    }

    //MARK: - public vars
    var title: String {
        return publication?.title ?? ""
    }

    var urlToImage: String {
        return publication?.urlToImage ?? "no image url in publication"
    }

    var isWatched: Bool {
        guard let publication = self.publication else { return false }
        guard let url = publication.urlToPublication else { return false }
        let arr = UserDefaults.standard.array(forKey: "watched") as? [String]
        return arr?.contains(url) ?? false
    }
}
