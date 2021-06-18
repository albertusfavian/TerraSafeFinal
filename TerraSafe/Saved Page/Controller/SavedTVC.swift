//
//  SavedTVC.swift
//  TerraSafe
//
//  Created by Mac-albert on 17/06/21.
//

import UIKit

class SavedTVC: UITableViewCell {

    @IBOutlet weak var mountainNameLabel: UILabel!
    @IBOutlet weak var trackViaLabel: UILabel!
    @IBOutlet weak var distanceLabelAndHour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
