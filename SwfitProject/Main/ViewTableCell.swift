//
//  ViewTableCell.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/05.
//

import UIKit

class ViewTableCell: UITableViewCell {

    @IBOutlet weak var lable_Title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
