//
//  HomeViewController.swift
//  TerraSafe
//
//  Created by Gede Wicaksana on 10/06/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var homeArray = [Mountain]()
    @IBOutlet weak var mountainCollectionView: UICollectionView!
    var selectedMountain: String?
    var mountainDescription: String?
    var mountainLocation: String?
    var mountainHeight: String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    
    override func viewDidLoad() {
        Initial().insertWholeData()
        loadMountain()
        let nib = UINib(nibName: "\(HomeCollectionViewCell.self)", bundle: nil)
        mountainCollectionView.register(nib, forCellWithReuseIdentifier: "homeCell")
    }
    
    
    
    
  
    
    
    
    func loadMountain(){
        let request : NSFetchRequest<Mountain> = Mountain.fetchRequest()
        do {
            homeArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        mountainCollectionView.reloadData()
    }
    
    
    
    
}










extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        cell.mountImage.image = UIImage(named: "\(homeArray[indexPath.row].mountainImage!)")
        cell.mountTitle.text = homeArray[indexPath.row].mountainName
        cell.mountTrackCount.text = homeArray[indexPath.row].mountainTrackCount
        cell.mountElevation.text = homeArray[indexPath.row].mountainElevation
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMountain = homeArray[indexPath.row].mountainName
        mountainDescription = homeArray[indexPath.row].mountainDesc
        mountainLocation = homeArray[indexPath.row].mountainLocation
        mountainHeight = homeArray[indexPath.row].mountainElevation
        performSegue(withIdentifier: "goToDetail", sender: self)
        
        // another way passing data
//        let cell = storyboard?.instantiateViewController(identifier: "TracksViewController") as? TracksViewController
//        cell?.selectedMountain = Mountains[indexPath.row].mountainName
//        self.navigationController?.pushViewController(cell!, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as? DetailInformationPageVC
        print(selectedMountain)
        destinationVC?.mountainNameVar = selectedMountain!
        destinationVC?.mountainDescVar = mountainHeight!
        destinationVC?.mountainLocationVar = mountainLocation!
        destinationVC?.mountainHeightVar = mountainDescription!
//            
//            destinationVC.mountain?.mountainName = selectedMountain
//            destinationVC.mountain?.mountainDesc = mountainDescription
//            destinationVC.mountain?.mountainLocation = mountainLocation
//            destinationVC.mountain?.mountainElevation = mountainHeight
        
        
    }
    
}
