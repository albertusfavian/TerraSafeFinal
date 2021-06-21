//
//  DownloadVC.swift
//  TerraSafe
//
//  Created by Mac-albert on 18/06/21.
//

import UIKit

class DownloadVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var downloadTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadTable.delegate = self
        downloadTable.dataSource = self
        downloadTable.separatorStyle = . none
        downloadTable.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let savedCell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedTVC
        savedCell.mountainNameLabel.text = "Gn Papandayan"
        savedCell.trackViaLabel.text = "Track Via Jalur selatan"
        savedCell.distanceLabelAndHour.text = "3 hour, 8,55km"
        savedCell.backgroundView = UIImageView(image: UIImage(named: "img_DownloadPage"))
        savedCell.layer.cornerRadius = 10
        savedCell.layer.borderWidth = 4
        savedCell.layer.borderColor = tableView.backgroundColor?.cgColor
        return savedCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 223
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
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
