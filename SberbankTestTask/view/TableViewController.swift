//
//  ViewController.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 06.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UpdateTableDelegate, UISearchBarDelegate {

    //MARK: - var, let, property
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel: TableViewModelType?

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TableViewModel(delegate: self)
        viewModel?.refreshData(searchWord: defaultSearchWord)
        searchBar.delegate = self
        tableView.separatorColor = .secondaryLabel
    }

    //MARK: - search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        var searchWord = searchBar.text ?? defaultSearchWord
        if searchWord.count == 0 {
            searchWord = defaultSearchWord
        }
        viewModel?.resetMaxNumberOfRows()
        viewModel?.refreshData(searchWord: searchWord)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    //MARK: - scroll view
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 0.0 {
            viewModel?.loadMore(searchWord: self.searchBar.text)
        }
    }

    //MARK: - table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        guard let tableCell = cell, let cellViewModel = viewModel?.cellViewModel(forRow: indexPath.row) else {
            return UITableViewCell()
        }
        tableCell.viewModel = cellViewModel
        return tableCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToDetailView", sender: indexPath)
        (tableView.cellForRow(at: indexPath) as! CustomTableViewCell).setWatched()
    }

    //MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailView" {
            if let vc = segue.destination as? DetailViewController, let row = (sender as? IndexPath)?.row {
                vc.viewModel = self.viewModel?.detailViewModel(forRow: row)
            }
        }
    }

    //MARK: - actions
    @IBAction func refresh(sender: UIRefreshControl) {
        sender.endRefreshing()
        viewModel?.resetMaxNumberOfRows()
        viewModel?.refreshData(searchWord: self.searchBar.text ?? defaultSearchWord)
    }

}

//MARK: - delegate
protocol UpdateTableDelegate {
    func onReadyDataLoad()
}

extension TableViewController {
    func onReadyDataLoad() {
        tableView.reloadData()
    }
}

