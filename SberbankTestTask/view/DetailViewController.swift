//
//  DetailViewController.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 07.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var urlToImageButton: UIButton!
    @IBOutlet weak var publishedAtLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var urlButton: UIButton!

    var viewModel:DetailViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        roundindSubviews()
        refreshFields()
        setUrlWatched()
    }
    
    func setUrlWatched(){
        guard let viewModel = self.viewModel else {return}
        viewModel.setUrlWached()
    }
    
    func roundindSubviews(){
        for k in self.view.subviews {
            if !(k is UILabel) {
                k.layer.cornerRadius = 15
                k.layer.masksToBounds = true
            }
        }
    }
    
    func refreshFields(){
        guard let viewModel = self.viewModel else {return}
        urlToImageButton.setTitle(viewModel.urlToImage, for: .normal)
        urlToImageButton.titleLabel?.numberOfLines = 2
        if viewModel.urlToImage != "no image url in publication" {
            urlToImageButton.setTitleColor(.link, for: .normal)
        } else {
            urlToImageButton.setTitleColor(.secondaryLabel, for: .normal)
        }
        publishedAtLable.text = viewModel.publishedAt
        titleLable.text = viewModel.title
        descriptionLable.text = viewModel.description
        urlButton.setTitle(viewModel.url, for: .normal)
        urlButton.titleLabel?.numberOfLines = 2
    }

    @IBAction func onUrlClick(sender: UIButton) {
        guard let url = URL(string: sender.title(for: .normal)!) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
