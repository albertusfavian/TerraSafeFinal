//
//  MapsViewController.swift
//  TerraSafe
//
//  Created by Gede Wicaksana on 11/06/21.
//

import UIKit
import CoreData

class MapsViewController: UIViewController{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Special pake telor buat bang rony
    var trackName: String?
    var bearing: Double?
    var latitude: Double?
    var longtitude: Double?
    var maxNorthEastLat: Double?
    var maxNorthEastLong: Double?
    var maxSouthWestLat: Double?
    var maxSouthWestLong: Double?
    
    
    
    
    // MARK -Initiate IBOutlet
    @IBOutlet weak var dragview: UIView!
    @IBOutlet weak var posDrawerView: UIView!
    @IBOutlet weak var wisataDrawerView: UIView!
    
    @IBOutlet weak var posImages: UICollectionView!
    @IBOutlet weak var posFacilities: UICollectionView!
    @IBOutlet weak var posDangers: UICollectionView!
    
    @IBOutlet weak var wisataImages: UICollectionView!
    @IBOutlet weak var wisataFacilities: UICollectionView!
    @IBOutlet weak var wisataDangers: UICollectionView!
    
    @IBOutlet weak var posTitle: UILabel!
    @IBOutlet weak var posDesc: UILabel!
    
    
    
    
    override func viewDidLoad() {
        let nib11 = UINib(nibName: "\(PosImageCollectionViewCell.self)", bundle: nil)
        posImages.register(nib11, forCellWithReuseIdentifier: "posImageCell")
        
        let nib12 = UINib(nibName: "\(PosFacilitiesCollectionViewCell.self)", bundle: nil)
        posFacilities.register(nib12, forCellWithReuseIdentifier: "posFacilitiesCell")
        
        let nib13 = UINib(nibName: "\(PosDangerCollectionViewCell.self)", bundle: nil)
        posDangers.register(nib13, forCellWithReuseIdentifier: "posDangerCell")
        
        let nib21 = UINib(nibName: "\(WisataImageCollectionViewCell.self)", bundle: nil)
        wisataImages.register(nib21, forCellWithReuseIdentifier: "wisataImageCell")
        
        let nib22 = UINib(nibName: "\(WisataFacilitiesCollectionViewCell.self)", bundle: nil)
        wisataFacilities.register(nib22, forCellWithReuseIdentifier: "wisataFacilitiesCell")
        
        let nib23 = UINib(nibName: "\(WisataDangerCollectionViewCell.self)", bundle: nil)
        wisataDangers.register(nib23, forCellWithReuseIdentifier: "wisataDangerCell")
        print(trackName!)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        DispatchQueue.main.async {
            self.dragview.center = CGPoint(x: self.dragview.center.x, y: 2000)
            self.wisataDrawerView.isHidden = true
            self.posDrawerView.isHidden = true
        }
    
    }

    
//     MARK: -Data Manipulation
    var PosImages = [
        posImagesData(posImage: UIImage(named: "img_pondok_saladah_1")!),
        posImagesData(posImage: UIImage(named: "img_pondok_saladah_2")!),
        posImagesData(posImage: UIImage(named: "img_pondok_saladah_3")!)
    ]

    var PosFacilities = [
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Water drop icon")!, posFacilitiesTitle: "Water Source"),
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Registration icon")!, posFacilitiesTitle: "Registration"),
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Parking slot icon")!, posFacilitiesTitle: "Parking Slot"),
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Waroeng icon")!, posFacilitiesTitle: "Waroeng"),
        posFacilitiesData(posFacilitiesImage: UIImage(named: "Camp icon")!, posFacilitiesTitle: "Camp")

    ]

    var PosDangers = [
        posDangersData(posDangerImage: UIImage(named: "Boar icon")!, posDangerTitle: "Boar")
    ]

    var WisataImages = [
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "img_tegal_alun_1")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "SignForLost.4")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "TerrainCondition.5"))
    ]

    var WisataFacilities = [
        wisataFacilitiesData(wisataFacilitiesImage: #imageLiteral(resourceName: "Water drop icon"), wisataFacilitiesTitle: "Water Source"),
        wisataFacilitiesData(wisataFacilitiesImage: UIImage(named: "Photo icon")!, wisataFacilitiesTitle: "Photo Spot")
    ]

    var WisataDangers = [
        wisataDangersData(wisataDangerImage: UIImage(named: "Sulphuric icon")!, wisataDangerTitle: "Sulphuric Atmosphere"),
        wisataDangersData(wisataDangerImage: UIImage(named: "Fog icon")!, wisataDangerTitle: "Occasional Thick Fog"),
        wisataDangersData(wisataDangerImage: UIImage(named: "Eruption icon")!, wisataDangerTitle: "Occasional Eruption")
    ]
    
    
//    func loadTrack(){
//        let request : NSFetchRequest<Track> = Track.fetchRequest()
//        let predicate = NSPredicate(format: "arrayTrack.trackName MATCHES %@", trackName!)
//        request.predicate = predicate
//        do {
//            arrayTrack = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
//
//    func loadPos(){
//        let request : NSFetchRequest<Pos> = Pos.fetchRequest()
//        let predicate = NSPredicate(format: "Track.trackName MATCHES %@", trackName!)
//        request.predicate = predicate
//        do {
//            arrayPos = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
    func removeAll(){
        PosImages.removeAll()
        PosFacilities.removeAll()
        PosDangers.removeAll()
    }
    func loadPos2(){
        posTitle.text = "Pos 2 (Camp Pondok Salada)"
        posDesc.text = "Steep and slippery on some track location, with reports about possible landslide. Be cautious along the track."
        PosImages = [
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_1")!),
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_2")!),
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_3")!)
        ]
        PosFacilities = [
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Water drop icon")!, posFacilitiesTitle: "Water Source"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Waroeng icon")!, posFacilitiesTitle: "Waroeng"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Camp icon")!, posFacilitiesTitle: "Camp")

        ]

        PosDangers = [
            posDangersData(posDangerImage: UIImage(named: "Boar icon")!, posDangerTitle: "Boar"),
            posDangersData(posDangerImage: UIImage(named: "Black panther icon")!, posDangerTitle: "Black Panther")
        ]
        posImages.reloadData()
        posDangers.reloadData()
        posFacilities.reloadData()
    }
    
    func loadPos3(){
        posTitle.text = "Pos 3 (Tegal Alun)"
        posDesc.text = "Slippery on some location, with sulphur aroma dominating the atmosphere. Be cautious along the track and use face mask to protect respiratory systems. This is the last post before reaching the summit, prepare in advance."
        PosImages = [
            posImagesData(posImage: UIImage(named: "img_tegal_alun_1")!),
            posImagesData(posImage: UIImage(named: "img_tegal_alun_2")!),
            posImagesData(posImage: UIImage(named: "img_pondok_saladah_3")!)
        ]
        PosFacilities = [
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Water drop icon")!, posFacilitiesTitle: "Water Source"),
            posFacilitiesData(posFacilitiesImage: UIImage(named: "Edelweiss icon")!, posFacilitiesTitle: "Edelweiss")

        ]

        PosDangers = [
            posDangersData(posDangerImage: UIImage(named: "Sulphuric icon")!, posDangerTitle: "Sulphur"),
            posDangersData(posDangerImage: UIImage(named: "Fog icon")!, posDangerTitle: "Fog")
        ]
        posImages.reloadData()
        posDangers.reloadData()
        posFacilities.reloadData()
    }
    
    
    
    // MARK: -Drawer Setup
    // tinggal di ganti conditionnya bang (Sorry manual, rada ngejer waktu bang)
    @IBAction func popup(_ sender: UIButton) {
        if  sender.titleLabel?.text == "Pos1"{
            dragview.center = CGPoint(x: dragview.center.x, y: 2000)
            posDrawerView.isHidden = false
            wisataDrawerView.isHidden = true
        }else if sender.titleLabel?.text == "Pos2"{
            dragview.center = CGPoint(x: dragview.center.x, y: 2000)
            removeAll()
            loadPos2()
            posDrawerView.isHidden = false
            wisataDrawerView.isHidden = true
        }else if sender.titleLabel?.text == "Pos3"{
            dragview.center = CGPoint(x: dragview.center.x, y: 2000)
            removeAll()
            loadPos3()
            posDrawerView.isHidden = false
            wisataDrawerView.isHidden = true
        }else if sender.titleLabel?.text == "Wisata"{
            dragview.center = CGPoint(x: dragview.center.x, y: 2000)
            posDrawerView.isHidden = true
            wisataDrawerView.isHidden = false
        }
        UIView.animate(withDuration: 0.3) { [self] in
            dragview.center = CGPoint(x: dragview.center.x, y: 950)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func emergencyCall(_ sender: UIButton){
        let alertController = UIAlertController(title: "Emergency Call", message: "Mountain Papandayan", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Call Nearest Police ", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Call Nearest Hospital", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteDrawer(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) { [self] in
            dragview.center = CGPoint(x: dragview.center.x, y: 2000)
        }
    }
    @IBAction func slide(_ sender: UIPanGestureRecognizer) {
        guard let targetView = sender.view else {return}
        var translation = sender.translation(in: dragview)
        let dragVelocity = sender.velocity(in: dragview)
        
        
        if targetView.center.y <= 500 && translation.y < 0{
            translation.y = 0
        }
        
        
       
        
        if dragVelocity.y >= 1000{
            translation.y = 0
            if targetView.center.y <= 800{
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 950)
                }
            } else if targetView.center.y >= 951 {
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 2000)
                }
            }
        
        }else if dragVelocity.y <= -1000 {
            translation.y = 0
            if targetView.center.y <= 949{
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 500)
                }
            }
            
            
        }
        if sender.state == .ended {
            translation.y = 0
            if (targetView.center.y <= 749 && targetView.center.y >= 500) {
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 500)
                }
                
            }else if (targetView.center.y >= 750 && targetView.center.y <= 1000) {
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 950)
                }
                
            }else if targetView.center.y >= 1001{
                UIView.animate(withDuration: 0.3) {
                    targetView.center = CGPoint(x: targetView.center.x, y: 2000)
                }
            }
        }
        
        targetView.center = CGPoint(x: targetView.center.x, y: targetView.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: view)
    }
    


}



// MARK: -Collection View Setup
extension MapsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView ==  posImages{
            return PosImages.count
        }else if collectionView == posFacilities{
            return PosFacilities.count
        }else if collectionView == posDangers{
            return PosDangers.count
        }else if collectionView == wisataImages{
            return WisataImages.count
        }else if collectionView == wisataFacilities{
            return WisataFacilities.count
        }else{
            return WisataDangers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == posImages{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posImageCell", for: indexPath) as! PosImageCollectionViewCell
            cell.posImage.image = PosImages[indexPath.row].posImage
            
            return cell
        }else if collectionView == posFacilities{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posFacilitiesCell", for: indexPath) as! PosFacilitiesCollectionViewCell
            cell.facilitiesImage.image = PosFacilities[indexPath.row].posFacilitiesImage
            cell.facilitiesTitle.text = PosFacilities[indexPath.row].posFacilitiesTitle
            
            return cell
        }else if collectionView == posDangers{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posDangerCell", for: indexPath) as! PosDangerCollectionViewCell
            cell.dangerImage.image = PosDangers[indexPath.row].posDangerImage
            cell.dangerTitle.text = PosDangers[indexPath.row].posDangerTitle
            
            return cell
        }else if collectionView == wisataImages{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wisataImageCell", for: indexPath) as! WisataImageCollectionViewCell
            cell.wisataImage.image = WisataImages[indexPath.row].wisataImage
            
            return cell
            
        }else if collectionView == wisataFacilities{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wisataFacilitiesCell", for: indexPath) as! WisataFacilitiesCollectionViewCell
            cell.facilitiesImage.image = WisataFacilities[indexPath.row].wisataFacilitiesImage
            cell.facilitiesTitle.text = WisataFacilities[indexPath.row].wisataFacilitiesTitle
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wisataDangerCell", for: indexPath) as! WisataDangerCollectionViewCell
            cell.dangerImage.image = WisataDangers[indexPath.row].wisataDangerImage
            cell.dangerTitle.text = WisataDangers[indexPath.row].wisataDangerTitle
            
            return cell
            
        }
        
    
    }
    
    
}
