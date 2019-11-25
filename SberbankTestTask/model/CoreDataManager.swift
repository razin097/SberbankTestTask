//
//  CoreDataManager.swift
//  SberbankTestTask
//
//  Created by Михаил Разин on 25.11.2019.
//  Copyright © 2019 Михаил Разин. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: CoreDataManagerType {
    
    func saveUrlToCoreData(stringUrl: String) {
        if stringUrl.count < 7 {
            return
        }
        if isUrlInCoreData(stringUrl: stringUrl){
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WatchedUrl", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! WatchedUrl
        taskObject.watchedUrl = stringUrl
    }
    
    func isUrlInCoreData(stringUrl: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var arr:[WatchedUrl] = []
        let fetchRequest: NSFetchRequest<WatchedUrl> = WatchedUrl.fetchRequest()
        do {
            arr = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        for k in arr {
            if k.watchedUrl == stringUrl {
                return true
            }
        }
        return false
    }

}

