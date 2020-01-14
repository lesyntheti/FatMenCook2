//
//  CollectionViewCell.swift
//  FatMenCook
//
//  Created by Guillaume Bayle on 10/12/2019.
//  Copyright © 2019 Guillaume Bayle. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var cellID: Int = 0
    
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    
    @IBAction func loadRecipe(_ sender: Any) {
        print("loading recipe...")
    }
    
    @IBAction func loadRecipe2(_ sender: UIButton) {
        print("loading recipe...")
        genericClassObject.currentRecipeID = self.cellID
        print (genericClassObject.currentRecipeID)
    }
    
}
