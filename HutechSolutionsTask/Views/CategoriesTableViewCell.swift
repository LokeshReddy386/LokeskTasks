//
//  CategoriesTableViewCell.swift
//  HutechSolutionsTask
//
//  Created by LokeshReddy on 02/04/21.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLab: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
