//
//  ViewController.swift
//  TerraSafe
//
//  Created by Mac-albert on 06/06/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        getArrayOfMountains()
    }

//    func getArrayOfMountains() {
//        guard let path = Bundle.main.path(forResource: "mountain", ofType: "json") else {
//            preconditionFailure("File not found")
//        }
//
//        let filePath = URL(fileURLWithPath: path)
//
//        do {
//            let data = try Data(contentsOf: filePath)
//            let decoder = JSONDecoder()
//            let mountains = try decoder.decode([Mountain].self, from: data)
//
//            for mountain in mountains {
//                // TODO: Nyimpen di sini untuk core data
////                var m = NSEntityDescription.insertNewObjectForEntityForName("Mountain", inManagedObjectContext: self.managedObjectContext!) as Mountain
////                m.title = mountain.title
////                m.elevation = Int(mountain.elevation)
////
////                var error : NSError? = nil
////                if !self.managedObjectContext!.save(&error) {
////                    NSLog("Unresolved error \(error), \(error!.userInfo)")
////                    abort()
////                }
//
//                print(mountain.title)
//                print(mountain.elevation)
//                print(mountain.geometry)
//            }
//        } catch {
//            print(error)
//        }
//    }
}

