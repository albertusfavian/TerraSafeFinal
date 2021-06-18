//
//  MapsViewController.swift
//  TerraSafe
//
//  Created by Gede Wicaksana on 11/06/21.
//

import UIKit

class MapsViewController: UIViewController{

    // Special pake telor buat bang rony
    var track: Track?
    
    
    
    
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

    
    // MARK: -Data Manipulation
    let PosImages = [
        posImagesData(posImage: #imageLiteral(resourceName: "Logo Onboarding")),
        posImagesData(posImage: #imageLiteral(resourceName: "Logo Onboarding")),
        posImagesData(posImage: #imageLiteral(resourceName: "Logo Onboarding")),
        posImagesData(posImage: #imageLiteral(resourceName: "Logo Onboarding")),
        posImagesData(posImage: #imageLiteral(resourceName: "Logo Onboarding")),
        posImagesData(posImage: #imageLiteral(resourceName: "Logo Onboarding")),
        posImagesData(posImage: #imageLiteral(resourceName: "Logo Onboarding")),
        posImagesData(posImage: #imageLiteral(resourceName: "Logo Onboarding"))
    ]
    
    let PosFacilities = [
        posFacilitiesData(posFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), posFacilitiesTitle: "Toilet"),
        posFacilitiesData(posFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), posFacilitiesTitle: "Toilet"),
        posFacilitiesData(posFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), posFacilitiesTitle: "Toilet"),
        posFacilitiesData(posFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), posFacilitiesTitle: "Toilet"),
        posFacilitiesData(posFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), posFacilitiesTitle: "Toilet"),
        posFacilitiesData(posFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), posFacilitiesTitle: "Toilet")
    
    ]
    
    let PosDangers = [
        posDangersData(posDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), posDangerTitle: "Babi"),
        posDangersData(posDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), posDangerTitle: "Babi"),
        posDangersData(posDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), posDangerTitle: "Babi"),
        posDangersData(posDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), posDangerTitle: "Babi"),
        posDangersData(posDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), posDangerTitle: "Babi"),
        posDangersData(posDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), posDangerTitle: "Babi"),
        posDangersData(posDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), posDangerTitle: "Babi")
    ]
    
    let WisataImages = [
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "Logo Onboarding")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "Logo Onboarding")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "Logo Onboarding")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "Logo Onboarding")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "Logo Onboarding")),
        wisataImagesData(wisataImage: #imageLiteral(resourceName: "Logo Onboarding"))
    ]
    
    let WisataFacilities = [
        wisataFacilitiesData(wisataFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataFacilitiesTitle: "Toilet"),
        wisataFacilitiesData(wisataFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataFacilitiesTitle: "Toilet"),
        wisataFacilitiesData(wisataFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataFacilitiesTitle: "Toilet"),
        wisataFacilitiesData(wisataFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataFacilitiesTitle: "Toilet"),
        wisataFacilitiesData(wisataFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataFacilitiesTitle: "Toilet"),
        wisataFacilitiesData(wisataFacilitiesImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataFacilitiesTitle: "Toilet")
    ]
    
    let WisataDangers = [
        wisataDangersData(wisataDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataDangerTitle: "Badak"),
        wisataDangersData(wisataDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataDangerTitle: "Badak"),
        wisataDangersData(wisataDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataDangerTitle: "Badak"),
        wisataDangersData(wisataDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataDangerTitle: "Badak"),
        wisataDangersData(wisataDangerImage: #imageLiteral(resourceName: "Logo Onboarding"), wisataDangerTitle: "Badak")
    ]
    

    
    
    
    
    // MARK: -Drawer Setup
    @IBAction func popup(_ sender: UIButton) {
        if  sender.titleLabel?.text == "Pos"{
            posDrawerView.isHidden = false
            wisataDrawerView.isHidden = true
        }else if sender.titleLabel?.text == "Wisata"{
            posDrawerView.isHidden = true
            wisataDrawerView.isHidden = false
        }
        UIView.animate(withDuration: 0.3) { [self] in
            dragview.center = CGPoint(x: dragview.center.x, y: 950)
        }
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
