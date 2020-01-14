//
//  GenericClass.swift
//  FatMenCook
//
//  Created by Guillaume Bayle on 26/12/2019.
//  Copyright © 2019 Guillaume Bayle. All rights reserved.
//

import Foundation

class GenericClass {
    var category: String
    var currentRecipeID: Int
    
    init(category: String, currentRecipeID: Int){
        self.category = category
        self.currentRecipeID = currentRecipeID
    }
}

var genericClassObject = GenericClass(category: "", currentRecipeID: 0)
