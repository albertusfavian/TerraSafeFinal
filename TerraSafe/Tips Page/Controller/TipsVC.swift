//
//  TipsVC.swift
//  TerraSafe
//
//  Created by Mac-albert on 16/06/21.
//

import UIKit

class TipsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "goToDetailTips", sender: self)
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tips.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tip_cell")as! TipsTVC
        
        //Get tip from array and set the labels
        let tip = Tips[indexPath.row]
        
        cell.tipLbl?.text = tip.title
        cell.tipImgView?.image = UIImage(named: tip.image)
        
        
        
//        let tip = tips [indexPath.row]
//        cell.tipLbl.text = tip
//        cell.tipImgView.image = UIImage(named: tip)
        
        
        cell.tipView.layer.cornerRadius
            = 10
        
//        cell.tipImgView.layer.cornerRadius = cell.tipImgView.frame.height / 2
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailTips"{
            let indexPath = tableView.indexPathForSelectedRow!
            let tipsChoosen = segue.destination as? DetailTipsViewController
            
            tipsChoosen?.objTips = Tips[indexPath.row].category
            tipsChoosen?.headTitle = Tips[indexPath.row].title
//            tipsChoosen?.numberPage = Tips[indexPath.row].title.v
            tipsChoosen?.numberPage = Tips[indexPath.row].category.count
        }
    }
}


