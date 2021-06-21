//
//  DetailInformationPageVC.swift
//  TerraSafe
//
//  Created by Mac-albert on 09/06/21.
//

import UIKit
import CoreData

class DetailInformationPageVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var trackArray = [Track]()
    var mountain = [Mountain]()
    var trackName: String?
    var bearing: Double?
    var latitude: Double?
    var longtitude: Double?
    var maxNorthEastLat: Double?
    var maxNorthEastLong: Double?
    var maxSouthWestLat: Double?
    var maxSouthWestLong: Double?

    
    
    @IBOutlet weak var tableTrack: UITableView!
    @IBOutlet weak var mountainNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    
    var mountainNameVar:String = ""
    var mountainDescVar:String = ""
    var mountainLocationVar:String = ""
    var mountainHeightVar:String = ""
    
    var listTemp: [Float] = []
    var listCondition: [String] = []
    var listContitionNew: [String] = []
    var listDate: [String] = []
    var i: Int = 0
    let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Malang&appid=3e6254eea851a148b52545bce50cba35&units=metric")
    let requestService = NetworkRequest()
    var indexImage: Int = 0

    
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
        tableTrack.delegate = self
        tableTrack.dataSource = self
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        requestService.pullJSONData(url: url) { tempArray, conditionArray, dateArray in
            self.listTemp = tempArray
            self.listCondition = conditionArray
            self.listDate = dateArray
            DispatchQueue.main.async { [self] in
                self.weatherCollectionView.reloadData()
                for condition in listCondition{
                    if condition == "Rain"{
                        listContitionNew.append("􀇈")
                    }
                    else if condition == "Clouds"{
                        listContitionNew.append("􀇔")
                    }
                }
                
            }
            print(self.listTemp, self.listCondition, self.listDate)
        }
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .red
        mountainNameLabel.text = mountainNameVar
        descriptionLabel.text = mountainDescVar
        locationLabel.text = mountainLocationVar
        heightLabel.text = mountainHeightVar
        
        
        // Do any additional setup after loading the view.
        
        loadTrack()
        
   
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackArray.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tracksCell", for: indexPath) as? TableTrackTableViewCell
        
        cell?.layer.cornerRadius = 10
        cell?.layer.borderWidth = 3
        cell?.layer.borderColor = tableView.backgroundColor?.cgColor

        cell?.contentView.backgroundColor = #colorLiteral(red: 0.2466135621, green: 0.4093926549, blue: 0.336640954, alpha: 1)
        cell?.trackNameLabel.text = trackArray[indexPath.row].trackName
        cell?.hourLabel.text = trackArray[indexPath.row].trackTime
        cell?.lengthLabel.text   = trackArray[indexPath.row].trackLength
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trackName = trackArray[indexPath.row].trackName
        bearing = trackArray[indexPath.row].bearing
        latitude = trackArray[indexPath.row].latitude
        longtitude = trackArray[indexPath.row].longtitude
        maxNorthEastLat = trackArray[indexPath.row].maxNorthEastLat
        maxNorthEastLong = trackArray[indexPath.row].maxNorthEastLong
        maxSouthWestLat = trackArray[indexPath.row].maxSouthWestLat
        maxSouthWestLong = trackArray[indexPath.row].maxSouthWestLong
        
        
        self.performSegue(withIdentifier: "goToMap", sender: nil)
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell
        cell?.layer.cornerRadius = 10
        
//        cell?.layer.backgroundColor = UIColor.red.cgColor
        print("Indexpath: \(indexPath.row)")
        print(listCondition)
//        print(listCondition)
//        if listCondition[indexPath.row] == "Rain"{
//            cell?.tempLabel.text = "􀇈"
//        }
//        else if listCondition[indexPath.row] == "Clouds"{
//            cell?.tempLabel.text = "􀇔"
//        }
//        cell?.conditionLabel.text = listCondition.count !0 ? listCondition[indexPath.row] : ""
        cell?.dateLabel.text = listDate.count != 0 ? (listDate[indexPath.row]) : ""
        cell?.tempLabel.text = listTemp.count != 0 ? "\(String(listTemp[indexPath.row]))°C" : ""
        cell?.conditionImages.image = UIImage(systemName: "cloud.rain.fill")
        cell?.timeLabel.text = "06.00WIB"
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
           return CGSize(width: 80, height: 80)
        }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controllerMap = segue.destination as? MapsViewController {
            controllerMap.trackName = trackName!
            controllerMap.bearing = bearing!
            controllerMap.longtitude = longtitude!
            controllerMap.latitude = latitude!
            controllerMap.maxNorthEastLong = maxNorthEastLong!
            controllerMap.maxNorthEastLat = maxNorthEastLat!
            controllerMap.maxSouthWestLong = maxSouthWestLong!
            controllerMap.maxSouthWestLat = maxSouthWestLat!
        
        }
        
        
    }
    
    func loadTrack(){
        let request : NSFetchRequest<Track> = Track.fetchRequest()
        let predicate = NSPredicate(format: "mountain.mountainName MATCHES %@", mountainNameVar)
        request.predicate = predicate
        do {
            trackArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableTrack.reloadData()
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


