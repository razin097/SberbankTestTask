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
    
    weak var viewModel: TableCellViewModel? {
        willSet(viewModel){
            titleLable.text = viewModel?.title
            urlToImageLable.text = viewModel?.urlToImage
            if viewModel?.isWatched == true {
                titleLable.alpha = 0.25
                urlToImageLable.alpha = 0.25
                watched.isHidden = false
            } else {
                titleLable.alpha = 1
                urlToImageLable.alpha = 1
                watched.isHidden = true
            }
        }
    }

}
