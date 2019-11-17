//
//  TableCellViewModelType.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 13.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

protocol TableCellViewModelType: class {
        
    init (publication: Publication?)
    
    var title:String {get}
    
    var urlToImage:String {get}
    
    var isWatched:Bool {get}
}
