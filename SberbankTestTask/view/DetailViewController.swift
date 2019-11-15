//
//  DetailViewController.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 07.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var text = "text"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for k in self.view.subviews {
            if k is UILabel {
                k.layer.cornerRadius = 15
                k.layer.masksToBounds = true
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
