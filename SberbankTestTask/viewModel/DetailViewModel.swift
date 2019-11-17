//
//  DetailViewModel.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 15.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

class DetailViewModel: TableCellViewModel, DetailViewModelType {
    
    //MARK: - public vars
    var url:String {
        return publication?.urlToPublication ?? ""
    }
    
    var description:String {
        return publication?.description ?? ""
    }
    
    var publishedAt:String {
        return publication?.publishedAt ?? ""
    }
    
    //MARK: - functions
    func setUrlWached(){
        var watched:[String] = (UserDefaults.standard.array(forKey: "watched") ?? [] )as! [String]
        print("watched = ", watched)
        if !(watched.contains(self.url)) {
            watched.append(url)
            UserDefaults.standard.set(watched, forKey: "watched")
            UserDefaults.standard.synchronize()
        }
    }
}
