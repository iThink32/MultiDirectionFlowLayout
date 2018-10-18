//
//  CustomCell.swift
//  TestMultipleDirectionCollectionView
//
//  Created by N.A Shashank on 18/10/18.
 
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.lightGray
    }
    
    func setData(title:String) {
        self.lblTitle.text = title
    }
    
}
