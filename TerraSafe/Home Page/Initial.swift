//
//  Initial.swift
//  TerraSafe
//
//  Created by Gede Wicaksana on 15/06/21.
//

import UIKit
import CoreData

class Initial {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayMountain = [Mountain]()
    var arrayTrack = [Track]()
    var arrayWisata = [Wisata]()
    var arrayPos = [Pos]()
    var arrayCollectionImage = [CollectionImagesPin]()
    var arrayCollectionFacilities = [CollectionFacilities]()
    var arrayCollectionDanger = [CollectionDanger]()
    
    // MARK: - Manipulation Data Source

    func saveItems(){
        do {
            try context.save()
        } catch {
            print("Error saving content: \(error)")
        }
    }

    
    func insertItemMountain(mountainImage: String, mountainName: String, mountainDesc: String, mountainLocation: String, mountainTrackCount: String, mountainElevation: String){
        let newItem = Mountain(context: context)
        newItem.mountainImage = mountainImage
        newItem.mountainName = mountainName
        newItem.mountainDesc = mountainDesc
        newItem.mountainLocation = mountainLocation
        newItem.mountainTrackCount = mountainTrackCount
        newItem.mountainElevation = mountainElevation
//        var listOfTrack : Set<Track>
//        var track:Track
//        newItem.addToTrack(track)
        arrayMountain.append(newItem)
        saveItems()
    }
    
    func insertItemTrack(mountainName: Mountain, trackName: String, trackLength: String, trackTime: String, trackLongtitude: Double, trackLatitude: Double, trackBearing: Double, maxNorthEastLat: Double, maxNorthEastLong: Double, maxSouthWestLat: Double, maxSouthWestLong: Double){
        let newItem = Track(context: context)
        newItem.trackName = trackName
        newItem.trackLength = trackLength
        newItem.trackTime = trackTime
        newItem.longtitude = trackLongtitude
        newItem.latitude = trackLatitude
        newItem.bearing = trackBearing
        newItem.mountain = mountainName
        newItem.maxNorthEastLat = maxNorthEastLat
        newItem.maxNorthEastLong = maxNorthEastLong
        newItem.maxSouthWestLat = maxSouthWestLat
        newItem.maxSouthWestLong = maxSouthWestLong
        arrayTrack.append(newItem)
        saveItems()
    }
    
    func insertItemWisata(trackName: Track, wisataName: String, wisataDesc: String, wisataReach: String){
        let newItem = Wisata(context: context)
        newItem.wisataName = wisataName
        newItem.wisataDesc = wisataDesc
        newItem.wisataReach = wisataReach
        newItem.track = trackName
        arrayWisata.append(newItem)
        saveItems()
    }
    
    func insertItemPos(trackName: Track, posName: String, posTime: String, posLength: String, posMdpl: String, posHourDate: String, posHourTime: String, posTrackCondition: String){
        let newItem = Pos(context: context)
        newItem.posName = posName
        newItem.posTime = posTime
        newItem.posLength = posLength
        newItem.posMdpl = posMdpl
        newItem.posHourDate = posHourDate
        newItem.posHourTime = posHourTime
        newItem.posTrackCondition = posTrackCondition
        arrayPos.append(newItem)
        saveItems()
    }
    
    func insertItemCollectionImagePos(posName: Pos, imageName: String){
        let newItem = CollectionImagesPin(context: context)
        newItem.image = imageName
        newItem.pos = posName
        arrayCollectionImage.append(newItem)
        saveItems()
    }
    
    func insertItemCollectionFacilitiesPos(posName: Pos, imageFacilitiesName: String, facilitiesName: String){
        let newItem = CollectionFacilities(context: context)
        newItem.facilitiesImage = imageFacilitiesName
        newItem.facilitiesName = facilitiesName
        newItem.pos = posName
        arrayCollectionFacilities.append(newItem)
        saveItems()
    }
    
    func insertItemCollectionDangerPos(posName: Pos, imageDangerName: String, dangerName: String){
        let newItem = CollectionDanger(context: context)
        newItem.dangerImage = imageDangerName
        newItem.dangerName = dangerName
        newItem.pos = posName
        
        arrayCollectionDanger.append(newItem)
        saveItems()
    }
    
    func insertItemCollectionImageWisata(wisataName: Wisata, imageName: String){
        let newItem = CollectionImagesPin(context: context)
        newItem.image = imageName
        newItem.wisata = wisataName
        arrayCollectionImage.append(newItem)
        saveItems()
    }
    
    func insertItemCollectionFacilitiesWisata(wisataName: Wisata, imageFacilitiesName: String, facilitiesName: String){
        let newItem = CollectionFacilities(context: context)
        newItem.facilitiesImage = imageFacilitiesName
        newItem.facilitiesName = facilitiesName
        arrayCollectionFacilities.append(newItem)
        saveItems()
    }
    
    func insertItemCollectionDangerWisata(wisataName: Wisata, imageDangerName: String, dangerName: String){
        let newItem = CollectionDanger(context: context)
        newItem.dangerImage = imageDangerName
        newItem.dangerName = dangerName
//        CollectionDanger.a
        arrayCollectionDanger.append(newItem)
        saveItems()
    }
    

    
    func insertWholeData(){
        
        // Mountain 1
        insertItemMountain(mountainImage: "mountainTest", mountainName: "Papandayan1", mountainDesc: "gunung pemula", mountainLocation: "Guntur", mountainTrackCount: "3 Tracks", mountainElevation: "2015")
        
            // Track 1.1
            insertItemTrack(mountainName: arrayMountain[0], trackName: "Jalur Camp David", trackLength: "4 km", trackTime: "3 Hours", trackLongtitude: 107.726672, trackLatitude: -7.3193251, trackBearing: 217, maxNorthEastLat: -7.1578835, maxNorthEastLong: 107.874903, maxSouthWestLat: -7.4221481, maxSouthWestLong: 107.5298637)
    

                // Wisata 1.1
                insertItemWisata(trackName: arrayTrack[0], wisataName: "Hutan Mati1", wisataDesc: "object wisata paling terkenal", wisataReach: "jalan dikit nyampe")
                    
                    // Wisata Image
        
                    // Wisata Facilities
        
                    // Wisata Dangers
                    
                // Wisata 1.2
                insertItemWisata(trackName: arrayTrack[0], wisataName: "Hutan Mati2", wisataDesc: "object wisata paling terkenal", wisataReach: "jalan dikit nyampe")
                
                    // Wisata Image

                    // Wisata Facilities

                    // Wisata Dangers
                    
                // Pos 1.1
                insertItemPos(trackName: arrayTrack[0], posName: "Pondok Salada1", posTime: "10 menit", posLength: "100m", posMdpl: "520 mdpl", posHourDate: "5 jam", posHourTime: "100 menit", posTrackCondition: "berat")
                
                    // Pos Image

                    // Pos Facilities

                    // Pos Dangers
        
                // Pos 1.2
                insertItemPos(trackName: arrayTrack[0], posName: "Pondok Salada2", posTime: "10 menit", posLength: "100m", posMdpl: "520 mdpl", posHourDate: "5 jam", posHourTime: "100 menit", posTrackCondition: "berat")
        
                    // Pos Image

                    // Pos Facilities

                    // Pos Dangers
        
        
        
        
        insertItemMountain(mountainImage: "mountainTest", mountainName: "Papandayan2", mountainDesc: "gunung pemula", mountainLocation: "Guntur", mountainTrackCount: "2 Tracks", mountainElevation: "2015")
        
        insertItemMountain(mountainImage: "mountainTest", mountainName: "Papandayan3", mountainDesc: "gunung pemula", mountainLocation: "Guntur", mountainTrackCount: "1 Tracks", mountainElevation: "2015")
        

        insertItemTrack(mountainName: arrayMountain[1], trackName: "Jalur Camp David", trackLength: "4 km", trackTime: "3 Hours", trackLongtitude: 107.726672, trackLatitude: -7.3193251, trackBearing: 217, maxNorthEastLat: -7.1578835, maxNorthEastLong: 107.874903, maxSouthWestLat: -7.4221481, maxSouthWestLong: 107.5298637)
        insertItemTrack(mountainName: arrayMountain[1], trackName: "Jalur Camp David", trackLength: "4 km", trackTime: "3 Hours", trackLongtitude: 107.726672, trackLatitude: -7.3193251, trackBearing: 217, maxNorthEastLat: -7.1578835, maxNorthEastLong: 107.874903, maxSouthWestLat: -7.4221481, maxSouthWestLong: 107.5298637)
        insertItemTrack(mountainName: arrayMountain[1], trackName: "Jalur Camp David", trackLength: "4 km", trackTime: "3 Hours", trackLongtitude: 107.726672, trackLatitude: -7.3193251, trackBearing: 217, maxNorthEastLat: -7.1578835, maxNorthEastLong: 107.874903, maxSouthWestLat: -7.4221481, maxSouthWestLong: 107.5298637)
    }
}

