//
//  TableCellNetwork.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 24.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//
import Foundation

class TableCellNetwork {

    private weak var delegate: TableCellViewModelDelegate?

    init(delegate: TableCellViewModelDelegate) {
        self.delegate = delegate
    }

    public func getPhoto(stringUrl: String) {
        guard let encoded = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let url = URL(string: encoded) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, let delegate = self.delegate else {
                self.delegate = nil
                return
            }
            delegate.onReadyLoadingPhoto(image: data)
        })
        task.resume()
    }

}
