//
//  StylistTableViewCell.swift
//  MiltonSwift
//
//  Created by Mr. Naveen Kumar on 05/06/21.
//

import UIKit

class StylistTableViewCell: UITableViewCell {

    @IBOutlet weak var stylistImageView: UIImageView!
    @IBOutlet weak var stylistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
