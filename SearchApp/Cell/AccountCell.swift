//
//  AccountCell.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 6.05.2022.
//

import UIKit

class AccountCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ibanLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var liraLabel: UILabel!
    @IBOutlet weak var kurusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        monthLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        monthLabel.textColor =  UIColor(red: CGFloat(89/255.0), green: CGFloat(89/255.0), blue: CGFloat(89/255.0), alpha: CGFloat(1.0))
        ibanLabel.textColor = UIColor(red: CGFloat(89/255.0), green: CGFloat(89/255.0), blue: CGFloat(89/255.0), alpha: CGFloat(1.0))
        nameLabel.textColor = UIColor(red: CGFloat(41/255.0), green: CGFloat(41/255.0), blue: CGFloat(41/255.0), alpha: CGFloat(1.0))
        dayLabel.textColor = UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))
        liraLabel.textColor = UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))
        kurusLabel.textColor = UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
