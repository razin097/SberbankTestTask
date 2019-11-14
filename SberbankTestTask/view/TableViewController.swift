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

class TableViewController: UITableViewController, UpdateTableDelegate {

    let searchField = UITextField()
    var viewModel: TableViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TableViewModel(delegate: self)
        viewModel?.getJsonFromApi(searchWord: defaultSearchWord)
        tableView.rowHeight = CGFloat(tableViewRowHeigth)

    }

    override func viewWillAppear(_ animated: Bool) {
//        presentSearchView()
    }

    func presentSearchView() {
        refreshSearchFrame()
        view.addSubview(searchField)
    }

    func refreshSearchFrame() {
        let frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 70)
        searchField.frame = frame
        searchField.backgroundColor = .lightGray
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
        let tableViewCell = UITableViewCell()
        tableViewCell.textLabel?.numberOfLines = 3
        tableViewCell.textLabel?.text = viewModel?.getPublication(forRow: indexPath.row)?.title

        return tableViewCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "goToDetailView", sender: self)
    }

}

