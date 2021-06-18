//
//  TracksViewController.swift
//  TerraSafe
//
//  Created by Gede Wicaksana on 10/06/21.
//

import UIKit
import CoreData
class TracksViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var trackArray = [Track]()
    var selectedMountain: String?
    var mountainDescription: String?
    var mountainLocation: String?
    var mountainHeight: String?
    var mountain: Mountain?
    
    @IBOutlet weak var testImage: UIImageView!
    
    @IBOutlet weak var trackTableView: UITableView!
    @IBOutlet weak var mountainTitleLabel: UILabel!
    @IBOutlet weak var mountainDescriptionLabel: UILabel!
    @IBOutlet weak var mountainHeightLabel: UILabel!
    @IBOutlet weak var mountainLocationLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
//        print(selectedMountain!)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "\(TrackTableViewCell.self)", bundle: nil)
        trackTableView.register(nib, forCellReuseIdentifier: "tracksCell")
        
        mountainTitleLabel.text = mountain?.mountainName
        mountainDescriptionLabel.text = mountainDescription
        mountainHeightLabel.text = mountainHeight
        mountainLocationLabel.text = mountainLocation
        
        loadTrack()
        
        
        // test
        testImage.image = UIImage(named: "Camp icon")
    }
    

    func loadTrack(){
        let request : NSFetchRequest<Track> = Track.fetchRequest()
        let predicate = NSPredicate(format: "mountain.mountainName MATCHES %@", selectedMountain!)
        request.predicate = predicate
        do {
            trackArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        trackTableView.reloadData()
    }
    
    
    
}


extension TracksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tracksCell", for: indexPath) as! TrackTableViewCell
        
        cell.trackTitle.text = trackArray[indexPath.row].trackName
        cell.trackTime.text = trackArray[indexPath.row].trackTime
        cell.trackLength.text = trackArray[indexPath.row].trackLength
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
}
