//
//  OtherTableCell.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/08.
//

import UIKit

class OtherTableCell: UITableViewCell {
    @IBOutlet weak var lab_Title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //cell 초기화 
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
