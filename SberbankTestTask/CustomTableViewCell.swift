//
//  CustomTableViewCell.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 14.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell, LoadPhotoDelegate {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var watched: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!

    var titleImage: (image: UIImage?, url: String) = (nil, "")

    deinit {
        print(#function, #file)
    }
    
    func setWatched() {
        titleLable.alpha = 0.25
        titleImageView.alpha = 0.25
        watched.isHidden = false
    }

    func setNotWatched() {
        titleLable.alpha = 1
        titleImageView.alpha = 1
        watched.isHidden = true
    }

    var viewModel: TableCellViewModelType? {
        willSet(viewModel) {
            viewModel?.setDelegate(delegate: self)
            titleLable.text = viewModel?.title
            if viewModel?.isWatched == true {
                self.setWatched()
            } else {
                self.setNotWatched()
            }
            if viewModel?.urlToImage == "no image url in publication" {
                titleImageView.image = UIImage(systemName: "photo")
            }
            else if let image = self.titleImage.image, let url = viewModel?.urlToImage, url == titleImage.url {
                titleImageView.image = image
            }
            else {
                titleImageView.image = UIImage(systemName: "slowmo")
                self.titleImage.url = viewModel?.urlToImage ?? ""
                viewModel?.getAndUpdatePicture()
            }

        }
    }
    
}

extension CustomTableViewCell {
    func onReadyLoadingPhoto(image: Data) {
        print(#function)
        self.titleImage.image = UIImage(data: image)
        titleImageView.image = self.titleImage.image
    }
}
