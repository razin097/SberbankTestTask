//
//  CustomTableViewCell.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 14.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var urlToImageLable: UILabel!
    @IBOutlet weak var watched: UILabel!
    
    func setWatched(){
        titleLable.alpha = 0.25
        urlToImageLable.alpha = 0.25
        watched.isHidden = false
    }
    
    func setNotWatched(){
        titleLable.alpha = 1
        urlToImageLable.alpha = 1
        watched.isHidden = true
    }
    
    weak var viewModel: TableCellViewModelType? {
        willSet(viewModel){
            titleLable.text = viewModel?.title
            urlToImageLable.text = viewModel?.urlToImage
            if viewModel?.urlToImage == "no image url in publication" {
                urlToImageLable.textColor = .secondaryLabel
            } else {
                urlToImageLable.textColor = .link
            }
            if viewModel?.isWatched == true {
                self.setWatched()
            } else {
                self.setNotWatched()
            }
        }
    }

}
