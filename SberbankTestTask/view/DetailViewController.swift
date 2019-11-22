//
//  DetailViewController.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 07.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - outlets
//    @IBOutlet weak var urlToImageButton: UIButton!
    @IBOutlet weak var publishedAtLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var urlButton: UIButton!

    //MARK: - var, let, property
    var viewModel: DetailViewModelType?

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshFields()
        setUrlWatched()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    //MARK: - functions logic
    func setUrlWatched() {
        guard let viewModel = self.viewModel else { return }
        viewModel.setUrlWached()
    }
    
    override func viewDidLayoutSubviews() {
        roundindSubviews()
    }

    func refreshFields() {
        guard let viewModel = self.viewModel else { return }
//        urlToImageButton.setTitle(viewModel.urlToImage, for: .normal)
//        urlToImageButton.titleLabel?.numberOfLines = 2
        if viewModel.urlToImage != "no image url in publication" {
//            urlToImageButton.setTitleColor(.link, for: .normal)
        } else {
//            urlToImageButton.setTitleColor(.secondaryLabel, for: .normal)
        }
        publishedAtLable.text = viewModel.publishedAt
        titleLable.text = viewModel.title
        descriptionLable.text = viewModel.description
        urlButton.setTitle(viewModel.url, for: .normal)
        urlButton.titleLabel?.numberOfLines = 2
    }

    //MARK: - functions UI
    func roundindSubviews() {
        for k in self.view.subviews {
            if !(k is UILabel) {
                k.layer.cornerRadius = 15
                k.layer.masksToBounds = true
            }
        }
    }

    //MARK: - actions
    @IBAction func onUrlClick(sender: UIButton) {
        guard let url = URL(string: sender.title(for: .normal)!) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
