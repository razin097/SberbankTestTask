//
//  LoadPhotoDelegate.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 25.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation

protocol LoadPhotoDelegate: AnyObject {
    func onReadyLoadingPhoto(image:Data)
}
