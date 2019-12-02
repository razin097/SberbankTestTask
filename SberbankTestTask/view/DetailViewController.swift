//
//  DetailViewController.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 07.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, LoadPhotoDelegate {

    //MARK: - outlets
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!


    //MARK: - var, let, property
    var viewModel: DetailViewModelType? {
        didSet {
            viewModel?.setUrlWatched()
        }
    }

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        roundindSubviews()
        refreshFields()
        setPhoto()
    }

    //MARK: - functions logic
    func setPhoto() {
        viewModel?.setDelegate(delegate: self)
        viewModel?.getAndUpdatePicture()
    }

    func refreshFields() {
        guard let viewModel = self.viewModel else { return }
        publishedAtLabel.text = viewModel.publishedAt
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
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

extension DetailViewController {
    func onReadyLoadingPhoto(image: Data) {
        imageView.image = UIImage(data: image)
    }
}
