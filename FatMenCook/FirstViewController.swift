//
//  FirstViewController.swift
//  FatMenCook
//
//  Created by Guillaume Bayle on 27/11/2019.
//  Copyright © 2019 Guillaume Bayle. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showMeatOnly(_ sender: Any) {
        
        genericClassObject.category = "meat"
        
    }
    
    @IBAction func showAllRecipes(_ sender: Any) {
        genericClassObject.category = ""
    }
    
    @IBAction func showVegeOnly(_ sender: Any) {
        genericClassObject.category = "dessert"
    }
    
    @IBAction func allRecipeButton(_ sender: UIButton) {
        genericClassObject.category = ""
    }
    
    @IBAction func breakfastButton(_ sender: UIButton) {
        genericClassObject.category = "breakfast"
    }
    
    @IBAction func highCarbsButton(_ sender: UIButton) {
        genericClassObject.category = "highCarbs"
    }
    
    @IBAction func ketoButton(_ sender: UIButton) {
        genericClassObject.category = "keto"
    }
    
    @IBAction func seafoodButton(_ sender: UIButton) {
        genericClassObject.category = "seafood"
    }
    
    @IBAction func vegetarianButton(_ sender: UIButton) {
        genericClassObject.category = "vegetarian"
    }
    
    @IBAction func meatButton(_ sender: UIButton) {
        genericClassObject.category = "meat"
    }
    
    @IBAction func sweetButton(_ sender: UIButton) {
        genericClassObject.category = "dessert"
    }
    
    
}

