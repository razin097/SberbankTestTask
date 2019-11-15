//
//  ViewController.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 06.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import UIKit

protocol UpdateTableDelegate {
    func onReadyDataLoad()
}

class TableViewController: UITableViewController, UpdateTableDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel: TableViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TableViewModel(delegate: self)
        viewModel?.getJsonFromApi(searchWord: defaultSearchWord)
        tableView.rowHeight = CGFloat(tableViewRowHeigth)
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchWord = searchBar.text ?? defaultSearchWord
        viewModel?.getJsonFromApi(searchWord: searchWord)
    }

    func onReadyDataLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        guard let tableCell = cell, let cellViewModel =  viewModel?.cellViewModel(forRow: indexPath.row) else {
            return UITableViewCell()
        }
        tableCell.viewModel = cellViewModel
        return tableCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToDetailView", sender: self)
    }

}

