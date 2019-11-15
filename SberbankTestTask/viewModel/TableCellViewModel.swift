//
//  TableCellViewModel.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 15.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

class TableCellViewModel: TableCellViewModelType {
    
    private let publication:Publication?
    
    init (publication: Publication?) {
        self.publication = publication
    }
    
    var title:String {
        return publication?.title ?? ""
    }
    
    var urlToImage:String {
        return publication?.urlToImage ?? ""
    }
    
    var isWatched = false
    
//
//    func getCell() -> CustomTableViewCell {
//        let cell = CustomTableViewCell()
//        cell.titleLable?.text = publication?.title ?? ""
//        cell.urlToImageLable?.text = publication?.author ?? ""
//        cell.titleLable?.numberOfLines = 3
//
//        return cell
//    }
}
