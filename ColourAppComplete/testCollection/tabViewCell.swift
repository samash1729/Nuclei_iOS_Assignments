//
//  tabViewCell.swift
//  testCollection
//
//  Created by Ashish Samanta on 31/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation
import UIKit

class tabViewCell : UITableViewCell{
    @IBOutlet weak var collectView: UICollectionView!
}

extension tabViewCell{
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collectView.delegate = dataSourceDelegate
        collectView.dataSource = dataSourceDelegate
        collectView.tag = row
        collectView.reloadData()
    }
    
}
