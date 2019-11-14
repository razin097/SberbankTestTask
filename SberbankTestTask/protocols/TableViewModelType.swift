//
//  TableViewModelType.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 13.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

protocol TableViewModelType {
    
    var numberOfRows:Int  {get}
    
    func getPublication(forRow: Int) -> Publication?
    
    func getJsonFromApi(searchWord: String)
    
}
