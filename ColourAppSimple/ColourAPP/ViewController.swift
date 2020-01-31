//
//  ViewController.swift
//  ColourAPP
//
//  Created by Ashish Samanta on 31/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colView.delegate = self
        colView.dataSource = self
        colView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func getColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }


}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = getColor()
        return cell
    }
}

