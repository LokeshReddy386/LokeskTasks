//
//  ExploreTableViewCell.swift
//  HutechSolutionsTask
//
//  Created by LokeshReddy on 02/04/21.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var exploreLab: UILabel!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
