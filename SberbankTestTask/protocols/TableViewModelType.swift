//
//  TableViewModelType.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 13.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

protocol TableViewModelType {

    //MARK: - init
    init(delegate:UpdateTableDelegate)
    
    //MARK: - rows counting
    var numberOfRows: Int {get}
    
    func resetMaxNumberOfRows()
    
    //MARK: - json get & parse
    func refreshData(searchWord: String)
    
    //MARK: - load more
    func loadMore(searchWord: String?)
        
    //MARK: - view models
    func cellViewModel(forRow: Int) -> TableCellViewModelType
    
    func detailViewModel(forRow: Int) -> DetailViewModelType
}
