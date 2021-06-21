//
//  TableTrackTableViewCell.swift
//  TerraSafe
//
//  Created by Mac-albert on 09/06/21.
//

import UIKit

class TableTrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var hourImage: UIImageView!
    @IBOutlet weak var distanceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
