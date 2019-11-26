//
//  TableViewModel.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 14.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

class TableViewModel: TableViewModelType, TableViewModelDelegate {

    //MARK: - var, let, property
    private weak var delegate: UpdateTableDelegate?
    private var publications: [Publication]?
    private var maxNumberOfRows = numberOfRowsInEachPart
    private lazy var networkManager: TableNetwork = TableNetwork(delegate: self)

    //MARK: - init
    required init(delegate: UpdateTableDelegate) {
        self.delegate = delegate
    }

    //MARK: - rows counting
    var numberOfRows: Int {
        guard let publications = publications else { return 0 }
        if publications.count > self.maxNumberOfRows {
            return maxNumberOfRows
        }
        return publications.count
    }

    func resetMaxNumberOfRows() {
        self.maxNumberOfRows = numberOfRowsInEachPart
    }

    //MARK: - json get & parse
    public func refreshData(searchWord: String) {
        if searchWord.count == 0 {
            onReadyGettingDataFromApi(data: [])
        } else {
            networkManager.getJsonFromApi(searchWord: searchWord.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }

    //MARK: - view models
    func cellViewModel(forRow: Int) -> TableCellViewModelType {
        let publication: Publication? = publications?[forRow]
        return TableCellViewModel(publication: publication)
    }

    func detailViewModel(forRow: Int) -> DetailViewModelType {
        let publication: Publication? = publications?[forRow]
        return DetailViewModel(publication: publication)
    }

    //MARK: - delegate
    private func updateTable() {
        DispatchQueue.main.async {
            self.delegate?.onReadyDataLoad()
        }
    }

}

protocol TableViewModelDelegate: AnyObject {
    func onReadyGettingDataFromApi(data: [Publication])
}

extension TableViewModel {
    func onReadyGettingDataFromApi(data: [Publication]) {
        self.publications = data
        self.updateTable()
    }
}
