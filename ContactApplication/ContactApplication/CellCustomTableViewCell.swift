//
//  CellCustomTableViewCell.swift
//  ContactApplication
//
//  Created by Ashish Samanta on 23/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class CellCustomTableViewCell: UITableViewCell {

    var index: IndexPath?
    var buttonDelegate: ContactController?
    var selector:Int?
    
    @IBOutlet weak var myPlaintext: UITextField!
 
    @IBOutlet weak var mybtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func mybtnTapped(_ sender: Any) {

        if let index = index {
            if let selector = selector{
                buttonDelegate?.incCount(index: index,select:selector)
            }
        }
    }
    
}
