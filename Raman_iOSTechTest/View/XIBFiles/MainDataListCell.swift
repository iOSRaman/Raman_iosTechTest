//
//  MainDataListCell.swift
//  Raman_iOSTechTest
//
//  Created by Genie Talk on 13/10/23.
//

import UIKit

class MainDataListCell: UICollectionViewCell {
    
    @IBOutlet var imgView:UIImageView!
    @IBOutlet var bgView:UIView!
    @IBOutlet var lblID:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 10 // Adjust the radius value to your preference
        bgView.layer.masksToBounds = true
    }

}
