//
//  TableCellViewModel.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 15.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation
import UIKit

class TableCellViewModel: TableCellViewModelType, TableCellViewModelDelegate {

    //MARK: - var, let, property
    internal let publication: Publication?
    private weak var delegate:LoadPhotoDelegate?
    private lazy var network:TableCellNetwork = TableCellNetwork(delegate: self)

    //MARK: - init
    required init (publication: Publication?) {
        self.publication = publication
    }
    
    deinit {
        print(#function, #file)
    }
    
    //MARK: - functions
    func setDelegate(delegate:LoadPhotoDelegate){
        self.delegate = delegate
    }
    
    func getAndUpdatePicture() {
        network.getPhoto(stringUrl: self.urlToImage)
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
        return CoreDataManager().isUrlInCoreData(stringUrl: url)
    }
    
    func loadImage(){
        if self.urlToImage != "no image url in publication"{
            self.getAndUpdatePicture()
        }
    }
    
}

protocol TableCellViewModelDelegate: AnyObject {
    func onReadyLoadingPhoto(image:Data)
}

extension TableCellViewModel {
    func onReadyLoadingPhoto(image:Data){
        print(#function)
        DispatchQueue.main.async {
            self.delegate?.onReadyLoadingPhoto(image: image)
        }
    }
}
