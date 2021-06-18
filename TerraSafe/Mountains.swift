//
//  Mountains.swift
//  TerraSafe
//
//  Created by Vivian Angela on 11/06/21.
//

import UIKit
import CoreData
import MapKit

class Mountains {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        lazy var context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
    var itemMountains:[Gunung]?
    var itemTrack:[Track]?
    var itemPos:[Pos]?
    var itemObject:[Objek]?
    
//    func dummyDataGunung()->[Gunung]{
//
//    }
//
//    func initDummyData(){
//        //sediakan dummy Data
//        var gunung = Gunung()
//        gunung.deskripsi = "ini adalh gunung bla bla"
//        var track = Track()
//        gunung.addToTrack(track)
//        var objek = Objek()
//        track.addToObjek(objek)
//
//    }
    
//    func insertMountain(name: String, tinggi: Float){
//        //insert data to CoreData
//
//    }
    
//    internal func decodeGeoJSON(from fileName: String) throws -> MKGeoJSONFeature? {
//        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
//            preconditionFailure("File not found")
//        }
//
//        let filePath = URL(fileURLWithPath: path)
//
//        var featureCollection: MKGeoJSONFeature?
//
//        do {
//            let data = try Data(contentsOf: filePath)
//            let result = try JSONDecoder().decode(MKGeoJSONFeature.self, from: data)
//            for feature in result.features {
//                print("name", feature.properties.name, "featureclass", feature.properties.featureclass)
//            }
//        } catch let err {
//            print(err)
//        }
//    }
    
    
    //Save JSON by converting it in into Data and saved to Core Data
//    func saveSpotsLocation(model: SpotsModel, packageId: String, regionName: String) {
//      let newUser = NSEntityDescription.insertNewObject(forEntityName: "SpotsDetail", into: context)
//      do {
//        let data = NSKeyedArchiver.archivedData(withRootObject: model.dictionaryRepresentation())
//        newUser.setValue(data, forKey: "data")
//        newUser.setValue(packageId, forKey: "packageId")
//        newUser.setValue(regionName, forKey: "regionName")
//        try context.save()
//      } catch {
//        print("failure")
//      }
//    }
    
    func insertMountain(){
        //insert data to CoreData
        let gunung = Gunung(context: context)
        gunung.nama = "Gn. Papandayan"
        gunung.deskripsi = "A popular strato volcano mountain amongst hikers known for its outstanding views"
        gunung.lokasi = "Kabupaten Garut, West Java"
        gunung.tinggi = "2.295 mdpl"
        
        let track = Track(context: context)
        track.nama = "Track via Patok Banteng (Recommended)"
        track.waktuTempuh = "3h"
        track.jarak = "4.1km"
        
        //add track to gunung
        gunung.addToTrack(track)
        
        track.fileGeojson = ""
        track.nomorBaseCamp = ""
        track.nomorRS = ""
        track.nomorPolisi = ""
        
        let pos = Pos(context: context)
        pos.nama = ["Pos 1 (Camp David)", "Pos 2 (Camp Pondok Salada", "Pos 3"]
        pos.waktuTempuh = ["Initial", "2h from 1st Post"]
        pos.jarak = ["initial", "2.4km"]
        pos.ketinggian = ["2.008 mdpl", "2.320 mdpl", ""]
        pos.foto = [""]
        pos.facilitiesIcon = [""]
        pos.facilities = ["water source", "sanitary", "camp site", "waroeng"]
        pos.dangerIcon = [""]
        pos.danger = [""]
        
        //add pos to track
        track.addToPos(pos)
        
        let objek = Objek(context: context)
        objek.nama = ["Hutan Mati"]
        objek.deskripsi = ["Remnants of a forest which condition caused by the massive eruption of Papandayan Mountain in 1772. Now, the Dead Forest of Papandayan serves as an appealing tourist attraction, known for its exotic view and invigorating atmosphere."]
        objek.foto = [""]
        objek.facilitiesIcon = [""]
        objek.facilities = [""]
        objek.possibleDangers = [""]
        objek.possibleDangersIcon = [""]
        objek.reachableVia = [""]
        
        //add objek to track
        track.addToObjek(objek)
        
    }
    
    func fetchDataMountains()-> [Gunung] {
        do {
            let request = Gunung.fetchRequest() as NSFetchRequest<Gunung>
            
            self.itemMountains = try context.fetch(request)
            
            //filtering
//            let pred = NSPredicate(format: "name CONTAINS %@", "ted") //variable
//            request.predicate = pred
            
            //sorting
//            let sort = NSSortDescriptor(key: "name", ascending: true)
//            request.sortDescriptors = [sort]
            
            DispatchQueue.main.async {
                //Refresh data
//                self.tableView.reloadData()
            }
            
        } catch {
            
        }
        return [Gunung]
    }
    
    func fetchDataTrack()-> [Track] {
        do {
            let request = Track.fetchRequest() as NSFetchRequest<Track>
            
            self.itemTrack = try context.fetch(request)
            
            DispatchQueue.main.async {
              
            }
            
        } catch {
            
        }
    }
    
    func fetchDataPos()-> [Pos] {
        do {
            let request = Pos.fetchRequest() as NSFetchRequest<Pos>
            
            self.itemPos = try context.fetch(request)
            
            DispatchQueue.main.async {
              
            }
            
        } catch {
            
        }
    }
    
    func fetchDataObject() -> [Objek]{
        do {
            let request = Objek.fetchRequest() as NSFetchRequest<Objek>
            
            self.itemObject = try context.fetch(request)
            
            DispatchQueue.main.async {
               
            }
            
        } catch {
            
        }
    }
    
    func saveData() {
        do {
            try context.save()
        }catch {
            
        }
    }
    
    
//    func requestData() {
//
//    }
    
//    let request : NSFetchRequest<ListOfQuestion> = ListOfQuestion.fetchRequest()
//
//            request.predicate = NSPredicate(format: "question = %@",question)
//
//            do {
//                arrayNoteDetail = try context.fetch(request)
//                questionDetailVariable1 = arrayNoteDetail[0].questionDetail1!
//                questionDetailVariable2 = arrayNoteDetail[0].questionDetail2!
//
//            } catch {
//                print("Error fetching data from context \(error)")
//            }
    
}
