//
//  DetailViewModelType.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 13.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

protocol DetailViewModelType: TableCellViewModelType {

    //MARK: - public vars
    var url: String { get }

    var description: String { get }

    var publishedAt: String { get }

    //MARK: - functions
    func setUrlWatched()

}
