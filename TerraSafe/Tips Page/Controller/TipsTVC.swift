//
//  TipsTVC.swift
//  Tips
//
//  Created by Bismo Widianto on 10/06/21.
//

import UIKit

class TipsTVC: UITableViewCell {

    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var tipImgView: UIImageView!
    @IBOutlet weak var tipLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
